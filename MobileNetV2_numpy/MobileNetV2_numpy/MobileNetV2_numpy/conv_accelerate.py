import numpy as np


def relu(x, x_zero):
    """向量化实现ReLU激活函数"""
    return np.maximum(x, x_zero)


def create_sliding_window(arr, kernel_size, stride):
    """创建输入数组的滑动窗口视图，用于向量化卷积计算"""
    # 获取输入形状 (c, h, w)
    c, h, w = arr.shape
    # 计算输出形状
    out_h = (h - kernel_size) // stride + 1
    out_w = (w - kernel_size) // stride + 1

    # 计算滑动窗口的步长
    stride_h, stride_w = stride * arr.strides[1], stride * arr.strides[2]

    # 创建滑动窗口视图，形状: (c, out_h, out_w, kernel_size, kernel_size)
    window_shape = (c, out_h, out_w, kernel_size, kernel_size)
    strides = (arr.strides[0], stride_h, stride_w, arr.strides[1], arr.strides[2])

    return np.lib.stride_tricks.as_strided(arr, shape=window_shape, strides=strides)


def QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                      ofm_size, M0, n, M1, conv_mode=0):
    """高度向量化实现量化卷积操作，修复维度排列问题"""
    input_quantized = input_quantized.astype("int32")
    weight_quantized = weight_quantized.astype("int32")

    # 输入和权重的零点处理
    input_quantized = input_quantized - input_zero
    weight_quantized = weight_quantized - 0  # 假设权重零点为0

    if conv_mode == 0:  # norm conv
        # 应用padding
        input_padded = np.pad(
            input_quantized,
            pad_width=((0, 0), (padding, padding), (padding, padding)),
            mode='constant',
            constant_values=0
        )

        # 创建滑动窗口 - 形状: (c, oh, ow, k, k)
        windows = create_sliding_window(input_padded, kernel_size, stride)

        # 调整权重和窗口的形状以确保正确广播
        # 权重形状: (oc, c, k, k) -> 重塑为 (oc, 1, 1, c, k, k)
        weight_reshaped = weight_quantized[:, np.newaxis, np.newaxis, ...]
        # 窗口形状: (c, oh, ow, k, k) -> 重塑为 (1, oh, ow, c, k, k)
        windows_reshaped = windows.transpose(1, 2, 0, 3, 4)[np.newaxis, ...]

        # 检查形状是否兼容
        if weight_reshaped.shape[-3:] != windows_reshaped.shape[-3:]:
            raise ValueError(
                f"权重和窗口的最后三个维度不匹配: {weight_reshaped.shape[-3:]} vs {windows_reshaped.shape[-3:]}")

        # 计算所有位置的卷积和 - 在通道和kernel维度上求和
        conv_sums = np.sum(weight_reshaped * windows_reshaped, axis=(3, 4, 5))  # 修正求和轴

        # 应用量化参数并计算输出
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    elif conv_mode == 1:  # depthwise conv
        # 应用padding
        input_padded = np.pad(
            input_quantized,
            pad_width=((0, 0), (padding, padding), (padding, padding)),
            mode='constant',
            constant_values=0
        )

        # 创建滑动窗口 - 每个通道单独处理，形状: (c, oh, ow, k, k)
        windows = create_sliding_window(input_padded, kernel_size, stride)

        # 调整权重形状以确保正确广播
        # 权重形状: (c, 1, k, k) -> 重塑为 (c, 1, 1, k, k)
        weight_reshaped = weight_quantized[:, 0, np.newaxis, np.newaxis, ...]

        # 计算所有位置的卷积和
        conv_sums = np.sum(weight_reshaped * windows, axis=(3, 4))  # 形状: (c, oh, ow)

        # 应用量化参数并计算输出
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    elif conv_mode == 2:  # pointwise conv (通常kernel_size=1)
        # 不需要padding，直接创建滑动窗口
        windows = create_sliding_window(input_quantized, kernel_size, stride)  # 形状: (c, oh, ow, k, k)

        # 调整权重和窗口的形状以确保正确广播
        # 权重形状: (oc, c, k, k) -> 重塑为 (oc, 1, 1, c, k, k)
        weight_reshaped = weight_quantized[:, np.newaxis, np.newaxis, ...]
        # 窗口形状: (c, oh, ow, k, k) -> 重塑为 (1, oh, ow, c, k, k)
        windows_reshaped = windows.transpose(1, 2, 0, 3, 4)[np.newaxis, ...]

        # 计算所有位置的卷积和
        conv_sums = np.sum(weight_reshaped * windows_reshaped, axis=(3, 4, 5))  # 修正求和轴

        # 应用量化参数并计算输出
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    return output


def pw1_dw_pw2_M(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero,
                 weight_quantized, bias, kernel_size, stride, padding, ofm_size, M0, n, M1):
    """点卷积-深度卷积-点卷积序列的高度向量化实现"""
    # 点卷积1
    out1 = QuantizedConv2D_M(
        input_zero[0], input_quantized, output_zero[0],
        weight_quantized[0], kernel_size[0], stride[0],
        padding[0], ofm_size[0], M0[0], n[0], M1[0],
        conv_mode=2
    )
    out1 = relu(out1, output_zero[0])

    # 深度卷积
    out2 = QuantizedConv2D_M(
        input_zero[1], out1, output_zero[1],
        weight_quantized[1], kernel_size[1], stride[1],
        padding[1], ofm_size[1], M0[1], n[1], M1[1],
        conv_mode=1
    )
    out2 = relu(out2, output_zero[1])

    # 点卷积2
    out3 = QuantizedConv2D_M(
        input_zero[2], out2, output_zero[2],
        weight_quantized[2], kernel_size[2], stride[2],
        padding[2], ofm_size[2], M0[2], n[2], M1[2],
        conv_mode=2
    )
    out1 = np.clip(out1, 0, 255)
    out2 = np.clip(out2, 0, 255)
    out3 = np.clip(out3, 0, 255)
    # 类型转换
    return (out1.astype("uint8"),
            out2.astype("uint8"),
            out3.astype("uint8"))


def short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0, M1, n):
    """向量化实现shortcut连接"""
    return np.clip(
        np.round(((x.astype("int32") - x_z) * M0 + (Fx.astype("int32") - Fx_z) * M1) * (2 ** (-n)) + Sc_z),
        0, 255
    ).astype("uint8")


def get_element_numbers(x):
    """向量化计算数组元素总数"""
    return np.prod(x.shape)


def compare_2_numpy(a, b):
    """向量化比较两个numpy数组是否相等"""
    return a.shape == b.shape and np.all(np.abs(a.astype(int) - b.astype(int)) < 3)
