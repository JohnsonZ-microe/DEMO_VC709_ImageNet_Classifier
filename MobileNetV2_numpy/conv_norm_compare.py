import numpy as np

def relu(x, x_zero):
    if len(x.shape) > 1:  # 如果是多维数组
        for i in range(x.shape[0]):  # 对数组中的每个维度嵌套循环
            relu(x[i], x_zero)
    elif len(x.shape) == 1:  # 如果是一维数组
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero

    return x

# conv_cal函数用于计算卷积操作，输出值为输出特征图中[out_i][out_j][out_k]位置的值,conv_mode表示卷积的类型
# conv_mode = 0: norm conv, 1: depthwise conv, 2: pointwise conv
def conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, out_i, out_j, out_k):
    if (conv_mode == 0):  # norm conv
        weight = weight_quantized[out_i]  # 取出第out_i个卷积核
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))  # 创建一个空的3D数组，尺寸为输入的深度和卷积核的大小，用于存储输入所需数据
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride * out_j + j][
                        stride * out_k + k]  # 将输入数据填充到input数组中，stride*out_j+j和stride*out_k+k是计算卷积时的索引位置

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


def QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                      ofm_size, M0, n, M1, conv_mode=0):  # input 3D, weight 4D
    input_quantized = input_quantized.astype("int32")  # 将输入量化后的数据转换为int32类型
    weight_quantized = weight_quantized.astype("int32")  # 将权重量化后的数据转换为int32类型
    if (conv_mode == 0):  # norm conv
        output = np.zeros((weight_quantized.shape[0], ofm_size, ofm_size))  # 创建一个空的3D数组，尺寸为卷积核个数（输出通道数）和输出特征图的大小
        # 对输入数据进行padding操作，创建一个新的数组input_quantized_padding，尺寸为原输入数据的高度和宽度加上两倍的padding
        input_quantized_padding = np.full(
            (input_quantized.shape[0], input_quantized.shape[1] + 2 * padding, input_quantized.shape[2] + 2 * padding),
            0)
        zero_temp = np.full(input_quantized.shape, input_zero)  # 将输入的零点值填充到一个和输入数据同样大小的数组中
        input_quantized = input_quantized - zero_temp  # 将输入数据减去零点值，得到量化后的输入数据
        # 将输入数据填充到input_quantized_padding数组中
        for i in range(input_quantized.shape[0]):
            for j in range(padding, padding + input_quantized.shape[1]):
                for k in range(padding, padding + input_quantized.shape[2]):
                    input_quantized_padding[i][j][k] = input_quantized[i][j - padding][k - padding]

        zero_temp = np.full(weight_quantized.shape, 0)  # 将权重的零点值填充到一个和权重数据同样大小的数组中（这里假设权重的零点值为0）
        weight_quantized = weight_quantized - zero_temp  # 将权重数据减去零点值，得到量化后的权重数据

        for i in range(output.shape[0]):
            for j in range(ofm_size):
                for k in range(ofm_size):
                    # 计算输出特征图中[out_i][out_j][out_k]位置的值，使用conv_cal函数进行卷积操作，并乘以M0，加M1[i]，再除以2的n次方（右移n位），最后加上输出的零点值
                    # item的作用是什么？ copilot：这里的 .item() 作用是将 numpy 标量类型（如 numpy.float32、numpy.int32 等）转换为 Python 的原生标量类型（如 float 或 int）。
                    # output[i][j][k] = conv_cal(conv_mode, input_quantized_padding, weight_quantized, kernel_size, stride, i, j, k).item()
                    output[i][j][k] = ((M0 * conv_cal(conv_mode, input_quantized_padding, weight_quantized, kernel_size,
                                                      stride, i, j, k)).item() + M1[i]) * (2 ** (-n)) + output_zero
                    # 将计算结果四舍五入到最近的整数
                    output[i][j][k] = np.round(output[i][j][k])
    elif (conv_mode == 1):  # depthwise conv
        output = np.zeros((input_quantized.shape[0], ofm_size, ofm_size))
        input_quantized_padding = np.full(
            (input_quantized.shape[0], input_quantized.shape[1] + 2 * padding, input_quantized.shape[2] + 2 * padding),
            0)
        zero_temp = np.full(input_quantized.shape, input_zero)
        input_quantized = input_quantized - zero_temp
        for i in range(input_quantized.shape[0]):
            for j in range(padding, padding + input_quantized.shape[1]):
                for k in range(padding, padding + input_quantized.shape[2]):
                    input_quantized_padding[i][j][k] = input_quantized[i][j - padding][k - padding]

        zero_temp = np.full(weight_quantized.shape, 0)
        weight_quantized = weight_quantized - zero_temp

        for i in range(output.shape[0]):
            for j in range(output.shape[1]):
                for k in range(output.shape[2]):
                    # 此处与norm conv的区别在于，卷积核是针对每个输入通道进行的，因此需要使用input_quantized_padding[i]来获取第i个输入通道的数据
                    # 此处weight_quantized[i][0]表示第i个卷积核的第一个通道
                    output[i][j][k] = (M0 * conv_cal(conv_mode, input_quantized_padding[i], weight_quantized[i][0],
                                                     kernel_size, stride, i, j, k).item() + M1[i]) * (
                                                  2 ** (-n)) + output_zero
                    output[i][j][k] = np.round(output[i][j][k])

    elif (conv_mode == 2):  # pointwise conv
        output = np.zeros((weight_quantized.shape[0], ofm_size, ofm_size))
        input_quantized = input_quantized - input_zero
        zero_temp = np.full(weight_quantized.shape, 0)
        weight_quantized = weight_quantized - zero_temp

        for i in range(output.shape[0]):
            for j in range(output.shape[1]):
                for k in range(output.shape[2]):
                    output[i][j][k] = (M0 * conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride,
                                                     i, j, k).item() + M1[i]) * (2 ** (-n)) + output_zero
                    output[i][j][k] = np.round(output[i][j][k])
    return output


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
    Hx = np.round(((x - x_z) * M0 + (Fx - Fx_z) * M1) * 2 ** (-n) + Sc_z)
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