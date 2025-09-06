import pickle
import numpy as np
import random
import pandas as pd
pytorch_layer1 = np.load("pytorch_layer1.npy")
hardware_layer1 = np.load("hardware_output_layer1.npy")
diff = pytorch_layer1 - hardware_layer1
print(diff.max(), diff.min(),diff.sum())
layer50 = np.load("software_output_layer50.npy")
print(layer50.shape)

layer50_1_2 = 960*[0]
print(layer50.shape[0])
for i in range(layer50.shape[0]):
    layer50_1_2[i] = layer50[i][2][1]
print(layer50_1_2)
with open("coe\\layer51_weight.p", "rb") as f:
    layer51_weight = pickle.load(f)
print(layer51_weight.shape)
layer51_weight_channel201 = layer51_weight[201]
print(layer51_weight_channel201.shape)
layer51_weight_channel201 = layer51_weight_channel201.reshape(960)
print(layer51_weight_channel201)
def two_arrays_to_xlsx(arr1, arr2, file_path, sheet_name="数据", col_names=["列1", "列2"]):
    """
    将两个数组分别存入Excel的第一列和第二列

    参数:
        arr1: 要存入第一列的数组
        arr2: 要存入第二列的数组
        file_path: 保存路径，如"result.xlsx"
        sheet_name: 工作表名称
        col_names: 列名列表，默认["列1", "列2"]
    """
    try:
        # 检查两个数组长度是否一致
        if len(arr1) != len(arr2):
            print(f"警告：两个数组长度不同（{len(arr1)} vs {len(arr2)}）")

        # 将两个数组组合成DataFrame
        df = pd.DataFrame({
            col_names[0]: arr1,
            col_names[1]: arr2
        })

        # 写入Excel文件
        df.to_excel(file_path, sheet_name=sheet_name, index=False)
        print(f"成功保存到 {file_path}")
        return True
    except Exception as e:
        print(f"保存失败：{str(e)}")
        return False


# 示例使用
if __name__ == "__main__":
    # 生成两个示例数组（替换为你的实际数组）
    array1 = [i for i in range(960)]  # 第一列数据
    array2 = [i * 2 for i in range(960)]  # 第二列数据

    # 保存到Excel
    two_arrays_to_xlsx(
        layer50_1_2,
        layer51_weight_channel201,
        "layer51_debug.xlsx",
        col_names=["data", "weight"]  # 可自定义列名
    )

pass