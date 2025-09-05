import cupy as np  # 使用CuPy进行GPU加速


# 确保所有输入都转换为CuPy数组
def to_cupy(arr):
    """将输入转换为CuPy数组（如果尚未是）"""
    if isinstance(arr, np.ndarray):
        return arr
    # 处理列表的特殊情况
    if isinstance(arr, list):
        # 检查列表元素是否为数组或可转换为数组
        try:
            # 尝试转换为CuPy数组
            return np.array(arr)
        except ValueError:
            # 如果整体转换失败，则逐个转换元素
            return [to_cupy(x) for x in arr]
    return np.array(arr)


def relu(x, x_zero):
    """向量化实现ReLU激活函数"""
    x = to_cupy(x)
    x_zero = to_cupy(x_zero)
    return np.maximum(x, x_zero)


def create_sliding_window(arr, kernel_size, stride):
    """创建输入数组的滑动窗口视图，用于向量化卷积计算"""
    arr = to_cupy(arr)
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
    """兼容CuPy的量化卷积实现"""
    # 转换所有输入为CuPy数组
    input_quantized = to_cupy(input_quantized).astype("int32")
    weight_quantized = to_cupy(weight_quantized).astype("int32")
    input_zero = to_cupy(input_zero)
    output_zero = to_cupy(output_zero)
    M0 = to_cupy(M0)
    n = to_cupy(n)
    M1 = to_cupy(M1)

    # 输入和权重的零点处理
    input_quantized = input_quantized - input_zero
    weight_quantized = weight_quantized - 0  # 假设权重零点为0

    if conv_mode == 0:  # norm conv
        # 应用padding - 使用标量0作为填充值（CuPy要求）
        input_padded = np.pad(
            input_quantized,
            pad_width=((0, 0), (padding, padding), (padding, padding)),
            mode='constant',
            constant_values=0  # 确保填充值是标量
        )

        # 创建滑动窗口 - 形状: (c, oh, ow, k, k)
        windows = create_sliding_window(input_padded, kernel_size, stride)

        # 调整权重和窗口的形状以确保正确广播
        weight_reshaped = weight_quantized[:, np.newaxis, np.newaxis, ...]
        windows_reshaped = windows.transpose(1, 2, 0, 3, 4)[np.newaxis, ...]

        # 计算所有位置的卷积和
        conv_sums = np.sum(weight_reshaped * windows_reshaped, axis=(3, 4, 5))

        # 应用量化参数并计算输出
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    elif conv_mode == 1:  # depthwise conv
        # 应用padding - 使用标量0作为填充值
        input_padded = np.pad(
            input_quantized,
            pad_width=((0, 0), (padding, padding), (padding, padding)),
            mode='constant',
            constant_values=0
        )

        windows = create_sliding_window(input_padded, kernel_size, stride)
        weight_reshaped = weight_quantized[:, 0, np.newaxis, np.newaxis, ...]
        conv_sums = np.sum(weight_reshaped * windows, axis=(3, 4))
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    elif conv_mode == 2:  # pointwise conv
        windows = create_sliding_window(input_quantized, kernel_size, stride)
        weight_reshaped = weight_quantized[:, np.newaxis, np.newaxis, ...]
        windows_reshaped = windows.transpose(1, 2, 0, 3, 4)[np.newaxis, ...]
        conv_sums = np.sum(weight_reshaped * windows_reshaped, axis=(3, 4, 5))
        output = np.round(((M0 * conv_sums + M1[:, np.newaxis, np.newaxis]) * (2 ** (-n))) + output_zero)

    return output


def pw1_dw_pw2_M(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero,
                 weight_quantized, bias, kernel_size, stride, padding, ofm_size, M0, n, M1):
    """点卷积-深度卷积-点卷积序列，兼容CuPy"""
    # 转换所有输入为CuPy数组，对列表元素逐个处理
    input_scale = to_cupy(input_scale)
    input_zero = [to_cupy(iz) for iz in input_zero]  # 逐个转换列表元素
    input_quantized = to_cupy(input_quantized)
    output_scale = to_cupy(output_scale)
    output_zero = [to_cupy(oz) for oz in output_zero]  # 逐个转换列表元素
    weight_scale = to_cupy(weight_scale)
    weight_zero = to_cupy(weight_zero)
    weight_quantized = [to_cupy(wq) for wq in weight_quantized]  # 逐个转换列表元素
    bias = [to_cupy(b) for b in bias]  # 关键修复：逐个转换bias列表元素
    kernel_size = to_cupy(kernel_size)
    stride = to_cupy(stride)
    padding = to_cupy(padding)
    ofm_size = to_cupy(ofm_size)
    M0 = [to_cupy(m0) for m0 in M0]  # 逐个转换列表元素
    n = [to_cupy(ni) for ni in n]  # 逐个转换列表元素
    M1 = [to_cupy(m1) for m1 in M1]  # 逐个转换列表元素

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

    return (out1, out2, out3)  # 保持CuPy数组格式，不在此处转换为NumPy


def short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0, M1, n):
    """兼容CuPy的shortcut连接"""
    x = to_cupy(x).astype("int32")
    Fx = to_cupy(Fx).astype("int32")
    result = np.clip(
        np.round(((x - x_z) * M0 + (Fx - Fx_z) * M1) * (2 ** (-n)) + Sc_z),
        0, 255
    ).astype("uint8")
    return result


def get_element_numbers(x):
    """计算数组元素总数"""
    return np.prod(to_cupy(x).shape).item()


def compare_2_numpy(a, b):
    """比较两个数组是否相等"""
    a = to_cupy(a)
    b = to_cupy(b)
    return a.shape == b.shape and np.all(np.abs(a.astype(int) - b.astype(int)) < 3).item()
