import pickle
import numpy as np
from pathlib import Path

# Little-endian binary conversion functions
bin8 = lambda x: ''.join(reversed([str((x >> i) & 1) for i in range(8)]))  # 8-bit little-endian
bin32 = lambda x: ''.join(reversed([str((x >> i) & 1) for i in range(32)]))  # 32-bit little-endian


# Ensure output directory exists
def ensure_dir(directory):
    Path(directory).mkdir(parents=True, exist_ok=True)


def process_all_layers(file_pairs, output_dir):
    """Process all layers, merge weights and M1 into respective files, and record address information"""
    ensure_dir(output_dir)

    # Initialize 9 BRAM weight data lists (accumulating all layers)
    weight_brams = [[] for _ in range(9)]
    # Initialize M1 accumulation list (all layers' M1 data concatenated)
    all_m1_data = []

    # Record address information for each layer
    layer_addresses = []
    # Track current starting addresses for weights and M1
    current_weight_addr = 0
    current_m1_addr = 0

    # Process each layer
    for weight_file, m1_file, layer_name in file_pairs:
        print(f"Processing {layer_name}...")

        # Record current layer's starting addresses
        layer_weight_start = current_weight_addr
        layer_m1_start = current_m1_addr

        # Process weights and accumulate
        layer_weight_data = process_layer_weight(weight_file, layer_name)
        # Calculate address count occupied by current layer's weights (same for all BRAMs)
        layer_weight_count = len(layer_weight_data[0]) if layer_weight_data else 0

        for bram_idx in range(9):
            weight_brams[bram_idx].extend(layer_weight_data[bram_idx])

        # Update weight starting address
        current_weight_addr += layer_weight_count

        # Process M1 and accumulate
        layer_m1_data = process_layer_m1(m1_file, layer_name)
        layer_m1_count = len(layer_m1_data)
        all_m1_data.extend(layer_m1_data)

        # Update M1 starting address
        current_m1_addr += layer_m1_count

        # Record current layer's address range
        layer_addresses.append({
            "layer_name": layer_name,
            "weight_start": layer_weight_start,
            "weight_end": current_weight_addr - 1,
            "weight_count": layer_weight_count,
            "m1_start": layer_m1_start,
            "m1_end": current_m1_addr - 1,
            "m1_count": layer_m1_count
        })

        # Output current layer's address information
        print(f"  {layer_name} address range:")
        print(
            f"  - Weights: start address {layer_weight_start}, end address {current_weight_addr - 1}, total {layer_weight_count} addresses")
        print(f"  - M1: start address {layer_m1_start}, end address {current_m1_addr - 1}, total {layer_m1_count} addresses")

    # Write merged weight files
    for bram_idx in range(9):
        with open(f"{output_dir}/weight_layer1_{bram_idx}.txt", "w+") as f:
            f.write("memory_initialization_radix=2;\n")
            f.write("memory_initialization_vector=\n")
            for addr, bin_str in enumerate(weight_brams[bram_idx]):
                # Verify binary string length is 72 bits
                if len(bin_str) != 72:
                    print(f"Warning: BRAM{bram_idx} address{addr} has incorrect length ({len(bin_str)} bits)")
                suffix = ";\n" if addr == len(weight_brams[bram_idx]) - 1 else ",\n"
                f.write(f"{bin_str}{suffix}")

    # Write merged M1 file
    with open(f"{output_dir}/m1_layer1.txt", "w+") as f:
        f.write("memory_initialization_radix=2;\n")
        f.write("memory_initialization_vector=\n")
        for addr, bin_str in enumerate(all_m1_data):
            suffix = ";\n" if addr == len(all_m1_data) - 1 else ",\n"
            f.write(f"{bin_str}{suffix}")

    # Save address information report
    with open(f"{output_dir}/layer_addresses.txt", "w+") as f:
        f.write("Layer Address Allocation Report:\n\n")
        for addr_info in layer_addresses:
            f.write(f"Layer Name: {addr_info['layer_name']}\n")
            f.write(
                f"  Weights: start address {addr_info['weight_start']} - end address {addr_info['weight_end']}, total {addr_info['weight_count']} addresses\n")
            f.write(
                f"  M1: start address {addr_info['m1_start']} - end address {addr_info['m1_end']}, total {addr_info['m1_count']} addresses\n\n")

    print(f"\nAll layer data has been merged, weight files and M1 file generated")
    print(f"Layer address allocation report saved to: {output_dir}/layer_addresses.txt")

    return layer_addresses


def process_layer_weight(weight_file, layer_name):
    """Process weights for a single layer, return list of binary data for 9 BRAMs"""
    with open(weight_file, "rb") as f:
        weight = pickle.load(f)

    layer_brams = [[] for _ in range(9)]
    weight_shape = weight.shape

    # Check if it's a pointwise convolution (N, C, 1, 1)
    if len(weight_shape) == 4 and weight_shape[2] == 1 and weight_shape[3] == 1:
        print(f"Detected pointwise convolution layer, shape: {weight_shape}")
        return process_pointwise_weight(weight)

    # Process first layer (3x3 convolution)
    elif layer_name == "layer1":
        N = weight.shape[0]
        padding = np.zeros((1, 3, 3, 3), dtype="int8")
        w = np.concatenate((weight, padding), axis=0)  # 33 convolution kernel groups
        depth = 11  # 33/3=11 rows
        w_9bram = np.zeros((9, depth, 9), dtype="int8")

        # Weight reorganization logic
        for i in range(w.shape[0]):
            depth_idx = int(i / 3)
            for j in range(w.shape[1]):
                for k in range(w.shape[2]):
                    for l in range(w.shape[3]):
                        bram_idx = k * 3 + l  # 3x3 position mapped to 9 BRAMs
                        group_idx = i % 3  # Every 3 convolution kernel groups form a group
                        w_9bram[bram_idx][depth_idx][group_idx * 3 + j] = w[i][j][k][l]

        # Binary conversion
        for bram_idx in range(9):
            for addr in range(depth):
                temp = ""
                for k in range(9):
                    temp = bin8(w_9bram[bram_idx][addr][k]) + temp
                layer_brams[bram_idx].append(temp)

    # Process other 3x3 convolution layers
    else:
        N, C, _, _ = weight.shape
        padding_count = (9 - N % 9) % 9
        padding = np.zeros((padding_count, C, 3, 3), dtype="int8")
        w = np.concatenate((weight, padding), axis=0)
        total_channels = w.shape[0]
        depth = total_channels // 9
        w_9bram = np.zeros((9, depth, 9), dtype="int8")

        # Weight reorganization
        for pos in range(9):
            row, col = pos // 3, pos % 3
            for addr in range(depth):
                for idx in range(9):
                    channel = addr * 9 + idx
                    val = w[channel][0][row][col] if C == 1 else w[channel][idx % C][row][col]
                    w_9bram[pos][addr][idx] = val

        # Binary conversion
        for bram_idx in range(9):
            for addr in range(depth):
                temp = ""
                for k in range(9):
                    temp = bin8(w_9bram[bram_idx][addr][k]) + temp
                layer_brams[bram_idx].append(temp)

    return layer_brams


def process_pointwise_weight(weight):
    """Process pointwise convolution weights (correctly implement address allocation for each kernel)"""
    N, C, _, _ = weight.shape  # e.g., (16, 32, 1, 1)
    layer_brams = [[] for _ in range(9)]

    # Number of addresses needed per kernel: 32 int8 requires 4 addresses (9*3=27, 32-27=5)
    addr_per_kernel = (C + 8) // 9  # Ceiling division formula
    print(f"Pointwise convolution: {N} output channels, {C} input channels, each kernel requires {addr_per_kernel} addresses")

    # Process each kernel in turn, each kernel is stored in the corresponding BRAM
    for kernel_idx in range(N):
        bram_idx = kernel_idx % 9  # Kernel i is stored in BRAM i%9

        # Allocate required addresses for current kernel
        for addr_offset in range(addr_per_kernel):
            # Collect 9 int8 data (pad with 0 if insufficient)
            data = []
            for i in range(9):
                pos = addr_offset * 9 + i
                if pos < C:
                    data.append(weight[kernel_idx][pos][0][0])
                else:
                    data.append(0)  # Pad with 0 to ensure 9 data points

            # Convert to 72-bit binary string
            bin_str = ""
            for d in data:
                bin_str = bin8(d) + bin_str  # Maintain little-endian concatenation

            # Add data only to the BRAM corresponding to current kernel
            layer_brams[bram_idx].append(bin_str)

    # Ensure all BRAMs have the same address length (pad shorter BRAMs with 0)
    max_depth = max(len(bram) for bram in layer_brams)
    for bram_idx in range(9):
        while len(layer_brams[bram_idx]) < max_depth:
            # Pad with 72-bit string of nine 0s
            zero_str = ''.join([bin8(0) for _ in range(9)])
            layer_brams[bram_idx].append(zero_str)

    return layer_brams


def process_layer_m1(m1_file, layer_name):
    """Process M1 for a single layer, return list of binary data for the layer"""
    with open(m1_file, "rb") as f:
        m1_data = pickle.load(f)

    # Ensure m1_data is a NumPy array, handle irregular data
    try:
        # Try direct conversion
        if not isinstance(m1_data, np.ndarray):
            m1_data = np.array(m1_data, dtype="int32")

        # If multi-dimensional array, try to flatten to 1D
        if m1_data.ndim > 1:
            print(m1_data.shape)
            m1_data = m1_data.flatten()

    except ValueError:
        # Handle irregularly shaped data (e.g., containing sublists of different lengths)
        print(f"Warning: M1 data for {layer_name} has irregular shape, attempting to flatten...")

        # Recursively flatten list
        def flatten(x):
            result = []
            for item in x:
                if isinstance(item, (list, np.ndarray)):
                    result.extend(flatten(item))
                else:
                    result.append(item)
            return result

        # Convert to array after flattening
        flat_data = flatten(m1_data)
        m1_data = np.array(flat_data, dtype="int32")

    layer_m1 = []

    if layer_name == "layer1":
        cout = len(m1_data)
        remainder = cout % 9
        depth = cout // 9 if remainder == 0 else (cout // 9 + 1) * 3
        m1_array = np.zeros((depth, 9), dtype="int32")

        for i in range(cout):
            a = int(i / 3)
            b_idx = i - a * 3
            m1_array[a][b_idx * 3] = m1_data[i]

        for addr in range(depth):
            temp = ""
            for j in range(9):
                temp = bin32(m1_array[addr][j]) + temp
            layer_m1.append(temp)

    else:
        padding_count = (9 - len(m1_data) % 9) % 9
        m1_padded = np.pad(m1_data, (0, padding_count), mode='constant', constant_values=0)
        depth = len(m1_padded) // 9
        m1_array = np.zeros((depth, 9), dtype="int32")

        for addr in range(depth):
            for idx in range(9):
                m1_array[addr][idx] = m1_padded[addr * 9 + idx]

            temp = ""
            for j in range(9):
                temp = bin32(m1_array[addr][j]) + temp
            layer_m1.append(temp)

    return layer_m1


if __name__ == "__main__":
    file_pairs = [
        ("layer1_weight.p", "layer1_M1.p", "layer1"),
        ("layer2_weight.p", "layer2_M1.p", "layer2"),
        ("layer3_weight.p", "layer3_M1.p", "layer3"),
        ("layer4_weight.p", "layer4_M1.p", "layer4"),
        ("layer5_weight.p", "layer5_M1.p", "layer5"),
        ("layer6_weight.p", "layer6_M1.p", "layer6"),
        ("layer7_weight.p", "layer7_M1.p", "layer7"),
        ("layer8_weight.p", "layer8_M1.p", "layer8"),
        ("layer9_weight.p", "layer9_M1.p", "layer9"),
        ("layer10_weight.p", "layer10_M1.p", "layer10"),
        ("layer11_weight.p", "layer11_M1.p", "layer11"),
        ("layer12_weight.p", "layer12_M1.p", "layer12"),
        ("layer13_weight.p", "layer13_M1.p", "layer13"),
        ("layer14_weight.p", "layer14_M1.p", "layer14"),
        ("layer15_weight.p", "layer15_M1.p", "layer15"),
        ("layer16_weight.p", "layer16_M1.p", "layer16"),
        ("layer17_weight.p", "layer17_M1.p", "layer17"),
        ("layer18_weight.p", "layer18_M1.p", "layer18"),
        ("layer19_weight.p", "layer19_M1.p", "layer19"),
        ("layer20_weight.p", "layer20_M1.p", "layer20"),
        ("layer21_weight.p", "layer21_M1.p", "layer21"),
        ("layer22_weight.p", "layer22_M1.p", "layer22"),
        ("layer23_weight.p", "layer23_M1.p", "layer23"),
        ("layer24_weight.p", "layer24_M1.p", "layer24"),
        ("layer25_weight.p", "layer25_M1.p", "layer25"),
        ("layer26_weight.p", "layer26_M1.p", "layer26"),
        ("layer27_weight.p", "layer27_M1.p", "layer27"),
        ("layer28_weight.p", "layer28_M1.p", "layer28"),
        ("layer29_weight.p", "layer29_M1.p", "layer29"),
        ("layer30_weight.p", "layer30_M1.p", "layer30"),
        ("layer31_weight.p", "layer31_M1.p", "layer31"),
        ("layer32_weight.p", "layer32_M1.p", "layer32"),
        ("layer33_weight.p", "layer33_M1.p", "layer33"),
        ("layer34_weight.p", "layer34_M1.p", "layer34"),
        ("layer35_weight.p", "layer35_M1.p", "layer35"),
        ("layer36_weight.p", "layer36_M1.p", "layer36"),
        ("layer37_weight.p", "layer37_M1.p", "layer37"),
        ("layer38_weight.p", "layer38_M1.p", "layer38"),
        ("layer39_weight.p", "layer39_M1.p", "layer39"),
        ("layer40_weight.p", "layer40_M1.p", "layer40"),
        ("layer41_weight.p", "layer41_M1.p", "layer41"),
        ("layer42_weight.p", "layer42_M1.p", "layer42"),
        ("layer43_weight.p", "layer43_M1.p", "layer43"),
        ("layer44_weight.p", "layer44_M1.p", "layer44"),
        ("layer45_weight.p", "layer45_M1.p", "layer45"),
        ("layer46_weight.p", "layer46_M1.p", "layer46"),
        ("layer47_weight.p", "layer47_M1.p", "layer47"),
        ("layer48_weight.p", "layer48_M1.p", "layer48"),
        ("layer49_weight.p", "layer49_M1.p", "layer49"),
        ("layer50_weight.p", "layer50_M1.p", "layer50"),
        ("layer51_weight.p", "layer51_M1.p", "layer51"),
        ("layer52_weight.p", "layer52_M1.p", "layer52"),
        ("layer53_weight.p", "layer53_M1.p", "layer53")
    ]

    output_directory = "./merged_bram_output"
    process_all_layers(file_pairs, output_directory)
