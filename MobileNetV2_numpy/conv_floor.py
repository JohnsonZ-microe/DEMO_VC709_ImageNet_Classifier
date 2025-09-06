import numpy as np
try:
    import cupy as cp
    xp = cp  # 有 GPU 就用 CuPy
except Exception:
    xp = np   # 没有就用 NumPy

# ------------------ ReLU（原地，严格等价你原始语义） ------------------

def relu(x, x_zero):
    xp.maximum(x, x_zero, out=x)
    return x

# 放在文件顶部附近

def _apply_affine_and_shift(conv, M0, M1, n, output_zero, xp):

    conv = conv.astype(xp.int64, copy=False)
    M0 = xp.asarray(M0, dtype=xp.int64)
    M1 = xp.asarray(M1, dtype=xp.int64)
    n  = xp.asarray(n)


    conv = (M0[..., None] * conv + M1[..., None])  # 广播到 (C, HW)

    # 用右移代替除以 2**n，避免 1<<n 的类型限制
    if n.ndim == 0:
        conv = xp.right_shift(conv, int(n.item()))
    else:
        if n.dtype.kind != 'i':
            n = n.astype(xp.int64)
        conv = xp.right_shift(conv, n[..., None])  # (C,1) 广播到 (C,HW)

    conv = conv + int(output_zero)
    return conv


# conv_cal函数用于计算卷积操作，输出值为输出特征图中[out_i][out_j][out_k]位置的值,conv_mode表示卷积的类型

# conv_mode = 0: norm conv, 1: depthwise conv, 2: pointwise conv

def conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, out_i, out_j, out_k):
    if (conv_mode == 0):  # norm conv
        weight = weight_quantized[out_i]  # 取出第out_i个卷积核
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))  # 创建一个空的3D数组，尺寸为输入的深度和卷积核的大小，用于存储输入所需数据
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride * out_j + j][stride * out_k + k]  # 将输入数据填充到input数组中，stride*out_j+j和stride*out_k+k是计算卷积时的索引位置


    elif (conv_mode == 1):  # depthwise conv
        weight = weight_quantized
        input = np.zeros((kernel_size, kernel_size))  # 创建和卷积核大小相同的二维数组
        for j in range(weight.shape[0]):
            for k in range(weight.shape[1]):
                input[j][k] = input_quantized[stride * out_j + j][stride * out_k + k]


    elif (conv_mode == 2):  # pointwise conv
        weight = weight_quantized[out_i]
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))  # 创建3*1*1尺寸的3D数组
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride * out_j + j][stride * out_k + k]

    return np.multiply(weight, input).sum()  # 将卷积核和输入数据相乘并求和，得到输出特征图中[out_i][out_j][out_k]位置的值


def _im2col_chw(x_u8, k, s, p, pad_val):
    C, H, W = x_u8.shape
    if p > 0:
        x_u8 = xp.pad(x_u8, ((0,0),(p,p),(p,p)), mode='constant', constant_values=pad_val)
    # CuPy/NumPy 的 sliding_window_view
    try:
    # CuPy: cupy.lib.stride_tricks.sliding_window_view
        swv = xp.lib.stride_tricks.sliding_window_view
    except AttributeError:
    # 老版本 CuPy 没有的话退回到 cupyx 实现（可选）
        from cupy.scipy.ndimage import generic_filter  # 兜底，不太建议，速度会差
        raise RuntimeError("Your CuPy version lacks sliding_window_view; please upgrade CuPy.")


    win = swv(x_u8, (k, k), axis=(1, 2))      # (C, H-k+1, W-k+1, k, k)
    win = win[:, ::s, ::s, :, :]              # 步长采样
    Hout, Wout = win.shape[1], win.shape[2]
    cols = win.reshape(C, Hout*Wout, k*k).transpose(0, 2, 1)  # (C, k*k, HW)
    cols = cols.reshape(C*k*k, Hout*Wout)                     # (C*k*k, HW)
    return cols, Hout, Wout




def _to_int64_floor(a):
    a = xp.asarray(a)
    if a.dtype.kind in ('f',):  # float
        a = xp.floor(a)
    return a.astype(xp.int64)

# ------------------ 严格语义卷积（不用 im2col，先对齐再谈加速） ------------------

def QuantizedConv2D_M(input_zero, input_quantized, output_zero,
weight_quantized, kernel_size, stride, padding, ofm_size,
M0, n, M1, conv_mode=0):


    k, s, p = kernel_size, stride, padding
    x = xp.asarray(input_quantized, dtype=xp.int32)
    w = xp.asarray(weight_quantized, dtype=xp.int32)


    # 先 pad 为 input_zero，再在“中心化域”里计算
    if p > 0:
        x = xp.pad(x, ((0,0),(p,p),(p,p)), mode='constant', constant_values=int(input_zero))
    x = x - int(input_zero)  # 与你原来“先减零点，再把边界当 0”语义等价

    # 统一的滑窗视图： (C, Hout, Wout, k, k)
    swv = xp.lib.stride_tricks.sliding_window_view
    Hpad, Wpad = x.shape[1], x.shape[2]
    Hout = (Hpad - k)//s + 1
    Wout = (Wpad - k)//s + 1
    win = swv(x, (k, k), axis=(1, 2))[:, ::s, ::s, :, :]  # (C, Hout, Wout, k, k)

    if conv_mode == 0:
        # ---- 普通卷积： w (Cout, Cin, k, k), x (Cin, Hout, Wout, k, k)
        Cout, Cin = w.shape[0], w.shape[1]
        # tensordot 做 sum_{Cin,k,k} 的相关
        conv = xp.tensordot(w, win, axes=((1,2,3),(0,3,4)))  # -> (Cout, Hout, Wout)
        conv = conv.reshape(Cout, -1)  # (Cout, HW)
        conv = _apply_affine_and_shift(conv, M0, M1, n, output_zero)
        out  = conv.reshape(Cout, Hout, Wout).astype(xp.int32)

    elif conv_mode == 1:
        # ---- 深度可分：w (Cin, 1, k, k) 或 (Cin, k, k)
        # 先规范成 (Cin, k, k)
        if w.ndim == 4:
            w = w.reshape(w.shape[0], w.shape[2], w.shape[3])
        Cin = w.shape[0]
        # 每通道相关： sum_{k,k} w[c]*win[c]
        conv = xp.einsum('cuv,cyxuv->cyx', w, win)
        conv = conv.reshape(Cin, -1)  # (Cin, HW)
        conv = _apply_affine_and_shift(conv, M0, M1, n, output_zero)
        out  = conv.reshape(Cin, Hout, Wout).astype(xp.int32)

    else:
        # ---- 1x1 PW： w (Cout, Cin, 1, 1)，x (Cin, H, W)
        Cin, Hall, Wall = x.shape
        Cout = w.shape[0]
        w2 = w.reshape(Cout, Cin)           # (Cout, Cin)
        # 相关： sum_{Cin} w * x
        conv = xp.tensordot(w2, x, axes=((1),(0)))  # -> (Cout, H, W)
        conv = conv.reshape(Cout, -1)               # (Cout, HW)
        conv = _apply_affine_and_shift(conv, M0, M1, n, output_zero)
        out  = conv.reshape(Cout, Hall, Wall).astype(xp.int32)

    return out


# pw1_dw_pw2_M函数与pw1_dw_pw2_M_cal函数类似，但使用了M0、n和M1作为参数，而不是直接计算它们的值。

def pw1_dw_pw2_M(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero,
    weight_quantized, bias, kernel_size, stride, padding, ofm_size, M0, n, M1):
    out1 = QuantizedConv2D_M(input_zero[0], input_quantized, output_zero[0], weight_quantized[0], kernel_size[0],
    stride[0], padding[0], ofm_size[0], M0[0], n[0], M1[0], conv_mode=2)
    out1 = relu(out1, output_zero[0])
    # print(out1.shape)
    out2 = QuantizedConv2D_M(input_zero[1], out1, output_zero[1], weight_quantized[1], kernel_size[1], stride[1],
    padding[1], ofm_size[1], M0[1], n[1], M1[1], conv_mode=1)
    out2 = relu(out2, output_zero[1])
    out3 = QuantizedConv2D_M(input_zero[2], out2, output_zero[2], weight_quantized[2], kernel_size[2], stride[2],
    padding[2], ofm_size[2], M0[2], n[2], M1[2], conv_mode=2)
    out1 = out1.astype("uint8")
    out2 = out2.astype("uint8")
    out3 = out3.astype("uint8")
    return out1, out2, out3

# short_cut_M函数用于计算shortcut连接的输出值

def short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0, M1, n):
# input feature map x and residual map Fx with their scale(s) and zero_point(z)
    x = x.astype("int32")
    Fx = Fx.astype("int32")
    # Hx为shortcut连接的输出值，具体计算方法为将输入特征图x和残差图Fx减去它们的零点值后，分别乘以M0和M1，然后相加，再除以2的n次方（右移n位），最后加上shortcut连接的零点值Sc_z
    Hx = np.floor(((x - x_z) * M0 + (Fx - Fx_z) * M1) * 2 ** (-n) + Sc_z)
    Hx = Hx.astype("uint8")
    return Hx

# get_element_numbers函数用于获取numpy数组的元素个数，具体实现方法为将数组的每个维度的大小相乘

def get_element_numbers(x):
    len_dim = len(x.shape)
    num = 1
    for i in range(len_dim):
        num = num * x.shape[i]
    return (num)

# compare_2_numpy函数用于比较两个numpy数组是否相等

def compare_2_numpy(a, b):
    if len(a) != len(b):  # 如果两个数组的长度不相等，则返回False
        return False
    else:  # 如果长度相等，则逐个元素比较
        for i in range(len(a)):
            if (abs(int(a[i]) - int(b[i])) >= 3):
                return False
    return True
