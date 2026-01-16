**中文版（Chinese version）**
# 一、项目概览


本项目实现了一个 **基于 FPGA 的 MobileNetV2 推理加速器**，通过对网络进行量化并在硬件中实现并行计算结构，从而加速 ImageNet 图像分类推理。硬件平台为 Xilinx VC709 FPGA 开发板。

软件部分基于 NumPy 实现了量化 MobileNetV2 的完整推理流程，并提供逐层输出机制，用于与硬件计算结果进行对比验证。

硬件加速器采用多路 MAC 阵列实现并行计算，并配套设计了与计算阵列数量一致的 BRAM 存储结构，以支撑并行数据访问与计算执行。

在 ImageNet 验证集上的实验结果如下：
- Top-1 Accuracy：**71.61%**
- Top-5 Accuracy：**90.11%**

相关方法参考以下论文：
- MobileNetV2: Inverted Residuals and Linear Bottlenecks 
  *Mark Sandler et al., CVPR 2018*
- Quantization and Training of Neural Networks for Efficient Integer-Arithmetic-Only Inference  
  *Benoit Jacob et al., CVPR 2018*

<!-- The Image classifier trained on the ImageNet dataset with the backbone of MobileNet-V2. The demo is built on the Xilinx VC709 evaluation board.

量化方法参考 B.Jacob:"Quantization and Training of Neural Networks for Efficient Integer-Arithmetic-Only Inference"。其中M0,M1分别为weight tensor与bias的缩放因子系数。 -->


# 二、软件部分

## 神经网络软件部分
.jpg、.JEPG文件为神经网络的输入，.npy、.pkl文件为参数M0、M1的数据PT文件用于保存模型,Imagenet_classes用于输出判断结果。

---
**量化MobileNetV2推理**
- **conv_round.py & conv_accelerate.py**
定义了基本的卷积运算函数（普通卷积、深度卷积、点卷积）和shortcut函数。
  - **conv_round.py**:使用循环嵌套的方式实现卷积
  - **conv_accelerate.py**:使用了向量化运算进行加速。

- **layer1_to_layer53_M_V1.py & MobileNetV2_numpy_simplified.py**
代码的核心部分，复现量化MobileNetV2神经网络的推理过程。
  - **layer1_to_layer53_M_V1.py**:比较冗杂，将每一层的参数配置和计算都写出来了，因此可以轻易的针对某一层进行修改。
  - **MobileNetV2_numpy_simplified.py**:前者的基础上简化的版本，使用循环来简化中间的bottleneck部分，代码量少了很多。

  由于两者调用的是`conv_round.py`，因此计算速度很慢，推理一张图需要数分钟。

- **MobileNetV2_numpy_accelerate.py**
调用`conv_accelerate.py`,使用向量化运算对神经网络进行了加速，加速后一秒内就可以推理完一张图。运行过程中会将每一层的输出保存为.npy文件并放到`outputs/`文件夹。

- **MobileNetV2_numpy_wrapper.py & MobileNetV2_numpy_imagenet.py**
  - **MobileNetV2_numpy_wrapper.py** :将模型包装为函数,调用`conv_accelerate.py`进行加速。
  - **MobileNetV2_numpy_imagenet.py**：在imagenet验证集上测试该模型的图像分类能力，使用前需设置验证集路径。

---
**numpy模型与torchvision模型对比**
- **compare_numpy_torchvision.py**
将torchvision模型中每一层的输入给到numpy模型中得到每一层的输出结果并进行比对，从而得到numpy模型的每一层输出与torchvision模型的差异。

---
**.coe文件生成**
- **coe_generate.py**
位于coe文件夹中，用于将每一层的M1、weight的.p文件转化为对应bram的txt文件用于初始化。txt文件可以在硬件设计的部分中使用`change.bat`转换成.coe文件。

---



## 验证代码


- **bram_reshape.py**
用于将vivado运行之后写出的bram.txt文件中的结果重组为每一层的输出结果，并作为npy文件保存到outputs文件夹中。只需要说明每一层的形状和地址范围即可。需要与仿真得到的txt文件处在同一文件夹。

- **compare_hardware_software_output.py**
位于outputs文件夹中。当运行了`MobileNetV2_numpy_accelerate.py`和`bram_reshape.py`这两个程序后，outputs文件夹中有存有神经网络的每一层输出的.npy文件。此时再运行该代码即可比较每一层的输出，比较结果会存储到comparison_results文件夹中。

---

# 三、硬件部分
## 加速器硬件架构
本节从整体角度介绍 FPGA 加速器的计算与存储架构设计。

![alt text](fig/Hardware_architecture.jpg)

由于MobileNetV2中普通卷积和深度卷积的卷积核尺寸均为3*3，因此本项目使用了9个BRAM来进行权重的存储。与此对应的也设计了9个BRAM对激活值进行存储，9个乘加阵列来进行计算。

---

## Vivado加速器工程文件
下图展示了加速器的 RTL 层级结构
```text
system_top (system_top.v)                            # 顶层模块
├── clk_gen_0                   (clk_wiz_0.xci)      # 时钟 IP
├── central_control             (central_control.sv) # 配置寄存器
├── counter_dw0                 (counter_dw.v)       # 控制器 & 数据预处理模块

├── mac_array_x9                (mac_array_x9.v)    # 计算子系统
│   ├── mode_arbiter0           (mode_arbiter.v)    # 阵列内部模式仲裁 / 控制
│   │   ├── ReLUandShift0~2     (ReLUandShift.v)    # ×3（普通卷积）
│   │   └── ReLUandShift_DW0~8  (ReLUandShift.v)    # ×9（DW & PW 使用）
│   └── mac_array1~9         (mac_array.v)          # 乘加阵列
│       ├── MAC1~9           (MAC.v)                # 乘加运算单元
│       ├── adder_tree_9     (adder_tree_9.v)       # 加法树
│       ├── shortcut         (shortcut.v)           # shortcut 模块
│       ├── m0xsigma_plus_m1 (m0xsigma_plus_m1.v)   # 量化处理模块
│       └── avgpool          (avgpool.v)            # 平均池化模块

├── BRAM_DMA0                (BRAM_DMA.v)           # 数据 BRAM-DMA
│   ├── Divider[*]           (divider.v)            # 除法器
├── Kernel_Bram_DMA0         (Kernel_Bram_DMA.v)    # 权重 BRAM-DMA

├── u_softmax                (softmax.v)            # softmax 模块
│   └── u_div                (div_gen_0.xci)        # 除法 IP

├── Data_Bram_0~8            (*.xci)                # 数据 BRAM
└── Kernel_Bram_0~*          (*.xci)                # 权重 BRAM

```

---------------------
## 主要模块说明
### system_top.v
加速器顶层模块，负责各子模块的集成、全局信号连接以及整体控制流程的组织。

---------------------
#### central_control.sv

配置寄存器模块，用于存储 MobileNetV2 各层的配置信息，包括：

- M0参数

- 输入 / 输出特征图起始地址

- shortcut 起始地址

- M1起始地址

- 输入 / 输出零点

- 特征图通道数与尺寸

- stride

- 操作类型（普通卷积、深度卷积、点卷积、shortcut、平均池化、softmax）

---
#### counter_dw.v
加速器的核心控制模块，负责整体数据流调度与时序控制，同时完成输入数据的预处理。

---
#### mac_array_x9.v
计算子系统顶层模块，内部包含 9 个并行的 `mac_array`，用于实现加速器的主要计算功能。

##### mac_array.v
乘加阵列模块，每个实例包含 9 个 MAC 运算单元。

- **MAC.v**
基本乘加运算模块，实现乘法与累加功能。

- **adder_tree_9.v**
九输入加法树模块，用于将 9 个 MAC 输出进行归约。
采用流水线结构，每次计算耗时 4 个时钟周期。

- **avgpool.v**
平均池化模块，实现平均池化操作。

- **shortcut.v**
残差连接模块，用于实现不同层输出之间的 shortcut 连接。

- **m0xsigma_plus_m1.v**
量化处理模块，实现 M0 * x + M1 运算，用于完成各层输出的缩放与量化。

- **mode_arbiter.v**
计算结果处理与拼接模块，负责不同计算模式下输出数据的选择与组织，内部包含多个 `ReLUandShift` 模块。
  - **ReLUandShift.v**
实现 ReLU 激活与移位操作的基础模块。

---

#### BRAM_DMA.v
数据BRAM的DMA模块，负责输入/输出地址的计算以及输入数据顺序的重排。
##### divider.v
除法器模块，采用流水线结构，每次计算耗时 2 个时钟周期。用于DMA中地址偏移的计算。

---
#### Kernel_Bram_DMA.v
权重 BRAM 的 DMA 控制模块，负责卷积权重及 M1 参数的地址生成与访问控制。

---

#### softmax.v
softmax 模块，用于实现网络最后一层的 softmax 计算。

---


# 四、运行及复现
## 软件执行验证
1.配置python运行环境（Numpy/torchvision/...)
2.运行`MobileNetV2_numpy_accelerate.py`文件，运行成功会得到下列结果。程序会打印出top5的类别以及概率。
![alt text](fig/acc_result.png)
如果希望能够得到该神经网络的accuracy，可以在下载imagenet验证集后运行`MobileNetV2_numpy_imagenet.py`。结果为：
- Top-1 Accuracy：**71.61%**
- Top-5 Accuracy：**90.11%**

具体打印信息保存在Validating.txt文件中。

---
## .coe文件生成
在coe文件夹中，存有每一层的权重和M1参数的.p文件。运行coe_generate可以得到9个存有权重的txt文件和1个存有M1的txt文件。此外，还有一个layer_addresses.txt文件，其中存储了每一层的权重和M1在BRAM中的地址。

---

## 加速器行为级仿真与验证
在Xilinx Vivado中，打开加速器工程项目。进行行为级仿真后，可以在`mobilenetv2_tcasii.sim`文件夹中找到生成的bram0.txt~bram8.txt文件。将这些文件拷贝到`MobileNetV2_numpy`文件夹中，并先后运行`bram_reshape.py` 和 `compare_hardware_software_output.py`之后，程序会打印出每一层的输出结果是否相等，如下图所示。
![alt text](fig/comparision_hard_soft.png)

---
## 加速器综合与bit流生成
在Vivado执行Synthesis和Implementation之后即可生成bitstream。

---

## Linux主机与VC709通信实现PCIe数据传输

---

## 上板验证

---

# 五、一些问题的解决过程


## 硬件设计的结果与pytorch模型的输出结果不一致
- **问题**：本项目使用numpy搭建的神经网络模型实际输出结果和torchvision.models.quantization.mobilenet_v2输出的结果一定程度上的不同
- **原因**：是所使用的M0 M1的精度有所不同。其中，本项目中使用的精度是int32，而在torchvision的模型中使用的精度是float64。

- **解决方法**：compare_each_layer的python代码中，使用的是numpy搭建的神经网络，读取torchvision模型中的input_scale, output scale, bias, weight scale，并用于计算M0 M1，使用float64精度。并且将torchvision模型的每一层的输入送入该模型中，避免产生累积误差。最后对每一层的输出进行比较。从运行结果中可以直观地看出，只有第51层输出中有5个数不同，其余层都是完全相同的。
然而，如果使用round对M0 M1进行处理，则会导致两个模型之间每一层输出都有一定程度上的差异。例如，在使用dog.jpg这张图片作为输入的时候，最终输出只有20%左右的数字是一样的。
但为了在设计的加速器上实现该神经网络，本项目必须使用int32作为M0 M1的精度。为了了解这样做对图像分类任务的效果造成的影响，在MobileNetV2_numpy_imagenet.py中使用了int32精度的M0 M1，并对imagenet的验证集的50000张图片进行推理，accuracy为top1：71.61%，top5：90.11%。而torchvision的模型的accuracy为top1：71.71%，top5：90.25%。这样的精度损失是完全可以接受的。

---

##	报错: RuntimeError: Quantized backend not supported
原因：当前环境不支持量化操作所需要的后端

问题原因：'qnnpack’是一种专为 ARM CPU 设计的量化后端，而 ‘fbgemm’ 则是一种适用于 x86 CPU 和 ARM CPU 的通用量化后端。

解决方法：修改torchvision中mobilenetv2的第74行，将backend从qnnpack改为fbgemm，如图：
![alt text](fig/f1.png)

---

## Linux主机与VC709通信实现PCIe数据传输时主机无法识别到VC709
现象：将VC709与Linux主机通过PCIe延长线连接之后，出现了主机开机时卡在Logo界面，无法进入系统的情况。

---


<!-- ## implicit declaration of mmiowb()
报错

解决方法：注释掉mmiowb(); -->

# 六、项目背景
本项目由赵忠宇、陈家宝于2021年实现了软件设计部分和硬件设计的主要模块。谢易达于2025年完善了硬件设计部分，并增加了用于验证结果的软件部分。王廉丰于2026年完成了PCIe通信以及最终的上板验证部分。
