import numpy as np
import pandas as pd
from pathlib import Path


def compare_npy_files(hardware_path, software_path, group_name="Unnamed Group"):
    """Compare a set of hardware and software generated npy files, record all difference positions"""
    try:
        # Load npy files
        hard = np.load(hardware_path)
        soft = np.load(software_path)

        # Convert to float32 to prevent overflow in subtraction
        hard = hard.astype(np.float32)
        soft = soft.astype(np.float32)

        # Ensure shapes are consistent
        if hard.shape != soft.shape:
            return {
                "group": group_name,
                "status": "Error",
                "message": f"Shape mismatch: hardware={hard.shape}, software={soft.shape}",
                "diff_count": None,
                "diffs": None,
                "full_diff_path": None
            }

        # Create difference mask
        diff_mask = hard != soft
        diff_indices = np.argwhere(diff_mask)
        diff_count = len(diff_indices)

        # Collect all differences
        all_diffs = []
        for idx in diff_indices:
            # Handle arrays of different dimensions (supports 2D or 3D)
            if len(idx) == 3:
                c, h, w = idx
                coords = (c, h, w)
                coord_names = ("Channel", "Height", "Width")
            elif len(idx) == 2:
                h, w = idx
                coords = (h, w)
                coord_names = ("Height", "Width")
            else:
                continue  # Unsupported dimension

            # Calculate difference
            diff_value = abs(hard[tuple(coords)] - soft[tuple(coords)])

            # Store difference information
            diff_info = {
                coord_names[0]: coords[0],
                coord_names[1]: coords[1],
                "Hardware Value": hard[tuple(coords)],
                "Software Value": soft[tuple(coords)],
                "Difference": diff_value
            }
            # Add channel information for 3D arrays
            if len(idx) == 3:
                diff_info[coord_names[2]] = coords[2]

            all_diffs.append(diff_info)

        if diff_count == 0:
            return {
                "group": group_name,
                "status": "Consistent",
                "message": "The two arrays are completely consistent",
                "diff_count": 0,
                "diffs": None,
                "full_diff_path": None
            }
        else:
            return {
                "group": group_name,
                "status": "Inconsistent",
                "message": f"Found {diff_count} differences in total",
                "diff_count": diff_count,
                "diffs": all_diffs,
                "total_elements": hard.size,
                "diff_ratio": diff_count / hard.size * 100,
                "full_diff_path": None
            }

    except FileNotFoundError as e:
        return {
            "group": group_name,
            "status": "Error",
            "message": f"File not found: {str(e)}",
            "diff_count": None,
            "diffs": None,
            "full_diff_path": None
        }
    except Exception as e:
        return {
            "group": group_name,
            "status": "Error",
            "message": f"Comparison failed: {str(e)}",
            "diff_count": None,
            "diffs": None,
            "full_diff_path": None
        }


def compare_multiple_groups(groups, output_dir="comparison_results"):
    """Compare multiple groups of npy file pairs and generate a complete difference report"""
    results = []

    # Create output directories
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)
    full_diff_dir = output_path / "full_differences"
    full_diff_dir.mkdir(parents=True, exist_ok=True)

    # Compare each group
    for i, group in enumerate(groups, 1):
        print(f"\n===== Comparing Group {i}: {group['name']} =====")
        result = compare_npy_files(
            group["hardware"],
            group["software"],
            group["name"]
        )

        # Save full differences to CSV
        if result["status"] == "Inconsistent" and result["diffs"]:
            diff_df = pd.DataFrame(result["diffs"])
            full_diff_path = full_diff_dir / f"{group['name']}_all_differences.csv"
            diff_df.to_csv(full_diff_path, index=False, encoding="utf-8")
            result["full_diff_path"] = str(full_diff_path)
            print(f"   All differences saved to: {full_diff_path}")

        results.append(result)

        # Print summary
        if result["status"] == "Consistent":
            print(f"✅ {result['message']}")
        elif result["status"] == "Inconsistent":
            print(f"❌ {result['message']}")
            print(f"   Difference ratio: {result['diff_ratio']:.4f}%")
        else:
            print(f"❌ {result['message']}")

    # Generate summary report
    summary = []
    for res in results:
        summary.append({
            "Group Name": res["group"],
            "Status": res["status"],
            "Difference Count": res["diff_count"] if res["diff_count"] is not None else "N/A",
            "Difference Ratio": f"{res['diff_ratio']:.4f}%" if res.get("diff_ratio") is not None else "N/A",
            "Full Difference File": res["full_diff_path"] if res["full_diff_path"] else "None",
            "Description": res["message"]
        })

    # Save summary to Excel
    summary_df = pd.DataFrame(summary)
    summary_path = output_path / "comparison_summary.xlsx"
    with pd.ExcelWriter(summary_path) as writer:
        summary_df.to_excel(writer, sheet_name="Summary", index=False)

        # Save first 1000 differences in Excel
        for res in results:
            if res["status"] == "Inconsistent" and res["diffs"]:
                limited_diffs = res["diffs"][:1000]
                diff_df = pd.DataFrame(limited_diffs)
                if len(res["diffs"]) > 1000:
                    note_row = {col: "" for col in diff_df.columns}
                    note_row[diff_df.columns[0]] = f"... Only first 1000 shown, total {len(res['diffs'])} differences"
                    diff_df = pd.concat([diff_df, pd.DataFrame([note_row])], ignore_index=True)
                diff_df.to_excel(writer, sheet_name=f"{res['group']}_Diffs", index=False)

    print(f"\n===== Comparison Completed =====")
    print(f"Summary report saved to: {summary_path}")
    print(f"Full difference files saved to: {full_diff_dir}")
    return results


def generate_comparison_groups(start_layer, end_layer, shortcut_layers=None):
    """
    动态生成比较组，确保shortcut层紧跟在对应层之后

    参数:
        start_layer: 起始层数
        end_layer: 结束层数
        shortcut_layers: 包含shortcut的层列表，如 [9, 15, 18]
    """
    groups = []
    shortcut_layers = shortcut_layers or []

    # 遍历每一层，先添加普通层，若有对应的shortcut层则紧随其后添加
    for layer in range(start_layer, end_layer + 1):
        # 添加普通层
        groups.append({
            "name": f"Layer{layer}",
            "hardware": f"hardware_output_layer{layer}.npy",
            "software": f"software_output_layer{layer}.npy"
        })

        # 如果当前层有shortcut，立即添加在普通层之后
        if layer in shortcut_layers:
            groups.append({
                "name": f"Layer{layer}_shortcut",
                "hardware": f"hardware_output_layer{layer}_shortcut.npy",
                "software": f"software_output_layer{layer}_shortcut.npy"
            })

    return groups


if __name__ == "__main__":
    # 配置参数 - 直接在代码中修改以下值
    start_layer = 1  # 起始层数
    end_layer = 54 # 结束层数
    shortcut_layers = [9,15,18,24,27,30,36,39,45,48]  # 包含shortcut的层列表，如 [9, 15, 18]，无则设为[]
    output_dir = "comparison_results"  # 结果输出目录

    # 生成比较组并执行比较
    comparison_groups = generate_comparison_groups(start_layer, end_layer, shortcut_layers)
    compare_multiple_groups(comparison_groups, output_dir)
