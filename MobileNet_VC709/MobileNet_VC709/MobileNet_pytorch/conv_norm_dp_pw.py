import numpy as np

def relu(x, x_zero):
    if len(x.shape) > 1: 
        for i in range(x.shape[0]):
            relu(x[i], x_zero)
    elif len(x.shape) == 1:
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero
    
    return x


def conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, out_i, out_j, out_k):
    if(conv_mode == 0):# norm conv
        weight = weight_quantized[out_i]
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride*out_j+j][stride*out_k+k]
    
    elif(conv_mode == 1):# depthwise conv
        weight = weight_quantized
        input = np.zeros((kernel_size, kernel_size))
        for j in range(weight.shape[0]):
            for k in range(weight.shape[1]):
                input[j][k] = input_quantized[stride*out_j+j][stride*out_k+k]    
    

    elif(conv_mode == 2):# pointwise conv
        weight = weight_quantized[out_i]
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride*out_j+j][stride*out_k+k]
   
    return np.multiply(weight,input).sum()


def QuantizedConv2D( input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size, conv_mode = 0):# input 3D, weight 4D
    input_quantized  = input_quantized.astype("int32") 
    weight_quantized = weight_quantized.astype("int32")
    if(conv_mode == 0):# norm conv
        output = np.zeros((weight_quantized.shape[0],ofm_size,ofm_size))
        input_quantized_padding = np.full((input_quantized.shape[0],input_quantized.shape[1]+2*padding,input_quantized.shape[2]+2*padding),0)
        zero_temp = np.full(input_quantized.shape,input_zero)
        input_quantized = input_quantized - zero_temp
        for i in range(input_quantized.shape[0]):
            for j in range(padding,padding + input_quantized.shape[1]):
                for k in range(padding,padding + input_quantized.shape[2]):
                    input_quantized_padding[i][j][k] = input_quantized[i][j-padding][k-padding]
    
        zero_temp = np.full(weight_quantized.shape, weight_zero)
        weight_quantized = weight_quantized - zero_temp
    
        for i in range(output.shape[0]):
            for j in range(ofm_size):
                for k in range(ofm_size):
                    output[i][j][k] = weight_scale*input_scale/output_scale*conv_cal(conv_mode, input_quantized_padding, weight_quantized, kernel_size, stride, i, j, k) + bias[i]/output_scale + output_zero
                    output[i][j][k] = round(output[i][j][k])

    elif(conv_mode == 1):# depthwise conv
        output = np.zeros((input_quantized.shape[0],ofm_size,ofm_size))
        input_quantized_padding = np.full((input_quantized.shape[0],input_quantized.shape[1]+2*padding,input_quantized.shape[2]+2*padding),0)
        zero_temp = np.full(input_quantized.shape,input_zero)
        input_quantized = input_quantized - zero_temp
        for i in range(input_quantized.shape[0]):
            for j in range(padding,padding + input_quantized.shape[1]):
                for k in range(padding,padding + input_quantized.shape[2]):
                    input_quantized_padding[i][j][k] = input_quantized[i][j-padding][k-padding]
    
        zero_temp = np.full(weight_quantized.shape, weight_zero)
        weight_quantized = weight_quantized - zero_temp
    
        for i in range(output.shape[0]):
            for j in range(output.shape[1]):
                for k in range(output.shape[2]):
                    output[i][j][k] = weight_scale*input_scale/output_scale*conv_cal(conv_mode, input_quantized_padding[i], weight_quantized[i][0], kernel_size, stride, i, j, k) + bias[i]/output_scale + output_zero
                    output[i][j][k] = round(output[i][j][k])
                    if(output[i][j][k] < 0):
                        output[i][j][k] = 0

    elif(conv_mode == 2):# pointwise conv
        output = np.zeros((weight_quantized.shape[0],ofm_size,ofm_size))
        # zero_temp = np.full(input_quantized.shape,input_zero)
        input_quantized = input_quantized - input_zero
        
        zero_temp = np.full(weight_quantized.shape, weight_zero)
        weight_quantized = weight_quantized - zero_temp
    
        for i in range(output.shape[0]):
            for j in range(output.shape[1]):
                for k in range(output.shape[2]):
                    output[i][j][k] = weight_scale*input_scale/output_scale*conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, i, j, k) + bias[i]/output_scale + output_zero
                    output[i][j][k] = round(output[i][j][k])

    
    return output

def pw1_dw_pw2(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size):

    out1 = QuantizedConv2D(input_scale[0], input_zero[0], input_quantized, output_scale[0], output_zero[0], weight_scale[0], weight_zero[0], weight_quantized[0], bias[0], kernel_size[0], stride[0], padding[0], ofm_size[0], conv_mode = 2)
    out1 = relu(out1, output_zero[0])
    #print(out1.shape)
    out2 = QuantizedConv2D(input_scale[1], input_zero[1], out1, output_scale[1], output_zero[1], weight_scale[1], weight_zero[1], weight_quantized[1], bias[1], kernel_size[1], stride[1], padding[1], ofm_size[1], conv_mode = 1)
    out2 = relu(out2, output_zero[1])
    out3 = QuantizedConv2D(input_scale[2], input_zero[2], out2, output_scale[2], output_zero[2], weight_scale[2], weight_zero[2], weight_quantized[2], bias[2], kernel_size[2], stride[2], padding[2], ofm_size[2], conv_mode = 2)
    return out1, out2, out3

def short_cut(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z):
    #input feature map x and residual map Fx with their scale(s) and zero_point(z)
    M1 = x_s/Sc_s
    M2 = Fx_s/Sc_s
    x = x.astype("int32")
    Fx = Fx.astype("int32")
    Hx = np.round((x-x_z)*M1 + (Fx-Fx_z)*M2 + Sc_z)
    return Hx