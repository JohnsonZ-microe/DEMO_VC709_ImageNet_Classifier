import torch
import torch.nn as nn
import torch.nn.quantized as qnn
from torch.ao.quantization import QuantStub, DeQuantStub
import torchvision
from torchvision import transforms
from PIL import Image


# -------------------------- 1. 自定义量化卷积层（M0/M1整数化） --------------------------
class CustomQuantizedConv2d(qnn.Conv2d):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.M0_int = None  # 整数化的M0（input_scale * weight_scale / output_scale）
        self.M1_int = None  # 整数化的M1（bias / output_scale）
        self.input_scale = None  # 输入张量的缩放因子（需外部传入）
        self.input_zero_point = None  # 输入张量的零点（需外部传入）

    def _compute_integer_M0_M1(self):
        """计算并四舍五入M0和M1为整数"""
        # 1. 获取量化参数（确保模型已完成量化，参数非空）

        assert isinstance(self.weight, torch.Tensor), f"权重类型错误：{type(self.weight)}"
        assert hasattr(self.weight, 'q_scale'), "权重不是量化张量（缺少q_scale方法）"
        assert self.input_scale is not None, "请先设置输入的scale"
        assert self.input_zero_point is not None, "请先设置输入的zero_point"
        assert self.weight is not None, "权重未初始化"

        # 2. 计算浮点数M0和M1
        weight_scale = self.weight.q_scale()  # 权重的缩放因子
        output_scale = self.scale  # 输出的缩放因子
        M0_float = (self.input_scale * weight_scale) / output_scale  # 缩放因子乘积

        # 3. 计算M1（若有偏置）
        if self.bias is not None:
            bias_np = self.bias.detach().numpy()
            M1_float = bias_np / output_scale  # 偏置缩放
        else:
            M1_float = 0.0

        # 4. 四舍五入为整数（使用PyTorch的舍入逻辑，与量化对齐）
        self.M0_int = torch.round(torch.tensor(M0_float)).int()
        if self.bias is not None:
            self.M1_int = torch.round(torch.tensor(M1_float)).int()
        else:
            self.M1_int = torch.tensor(0).int()

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        """重写前向传播：使用整数M0/M1计算"""
        # 首次运行时计算整数M0/M1
        assert x.dtype == torch.quint8, f"输入必须是量化张量（torch.quint8），但得到{x.dtype}"
        if self.M0_int is None or self.M1_int is None:
            self._compute_integer_M0_M1()

        # 步骤1：输入去零点（量化整数 -> 有符号整数）
        x_int = (x.to(torch.int32) - self.input_zero_point)

        # 步骤2：权重去零点（量化整数 -> 有符号整数）
        weight_int = (self.weight.to(torch.int32) - self.weight.q_zero_point())

        # 步骤3：整数卷积计算（模拟PyTorch的量化卷积逻辑）
        conv_out = torch.nn.functional.conv2d(
            x_int.float(),  # 临时转float计算（实际硬件可直接整数运算）
            weight_int.float(),
            stride=self.stride,
            padding=self.padding,
            dilation=self.dilation,
            groups=self.groups
        ).to(torch.int32)

        # 步骤4：应用整数M0和M1调整
        if self.bias is not None:
            conv_out = conv_out * self.M0_int + self.M1_int
        else:
            conv_out = conv_out * self.M0_int

        # 步骤5：映射回输出量化范围（加零点 + 饱和截断）
        output_int = conv_out + self.zero_point
        output = torch.clamp(output_int, 0, 255).to(torch.uint8)  # 量化输出为uint8

        return output


# -------------------------- 2. 替换模型中的量化卷积层 --------------------------
def replace_quant_conv_layers(model, input_scale, input_zero_point):
    for name, module in list(model.named_children()):
        if isinstance(module, qnn.Conv2d):
            custom_conv = CustomQuantizedConv2d(
                in_channels=module.in_channels,
                out_channels=module.out_channels,
                kernel_size=module.kernel_size,
                stride=module.stride,
                padding=module.padding,
                dilation=module.dilation,
                groups=module.groups,
                bias=module.bias is not None
            )
            # 1. 正确获取权重张量（带括号）
            custom_conv.weight = module.weight()
            # 2. 正确获取偏置张量（带括号，若存在）
            if module.bias is not None:
                custom_conv.bias = module.bias()  # 关键修正：加()获取实际张量
            # 其他参数不变
            custom_conv.scale = module.scale
            custom_conv.zero_point = module.zero_point
            custom_conv.input_scale = input_scale
            custom_conv.input_zero_point = input_zero_point

            setattr(model, name, custom_conv)
        elif hasattr(module, 'named_children'):
            replace_quant_conv_layers(module, input_scale, input_zero_point)
    return model


# -------------------------- 3. 图像预处理（量化输入） --------------------------
def preprocess_image(image_path):
    """
    仅做标准化，不手动量化（保持float32类型，交给模型的quant层处理）
    Returns:
        float32张量（shape: [1, C, H, W]）
    """
    transform = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),  # 转为[0,1]的float32张量
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])  # 标准预处理
    ])

    image = Image.open(image_path).convert('RGB')
    x_float = transform(image).unsqueeze(0)  # [1, 3, 224, 224], float32
    return x_float  # 直接返回float32，不手动量化


# -------------------------- 4. 主函数：加载模型、修改、推理 --------------------------
def main(image_path="dog.jpg"):
    # 1. 加载预训练的量化MobileNetV2
    model = torchvision.models.quantization.mobilenet_v2(
        pretrained=True,
        quantize=True
    ).eval()

    # 2. 获取模型输入的量化参数（从QuantStub获取，用于后续自定义层）
    input_scale = model.quant.scale.item()
    input_zero_point = model.quant.zero_point.item()
    print(f"输入量化参数：scale={input_scale:.6f}, zero_point={input_zero_point}")

    # 3. 替换模型中的量化卷积层为自定义层
    model = replace_quant_conv_layers(model, input_scale, input_zero_point)
    print("已替换量化卷积层为自定义层（M0/M1整数化）")

    # 4. 预处理图像（仅标准化，不手动量化，保持float32）
    x_float = preprocess_image(image_path)  # 这里是float32
    print(f"输入形状：{x_float.shape}, 数据类型：{x_float.dtype}")

    # 5. 推理
    with torch.no_grad():
        output = model(x_float)  # 模型的quant层会自动将float32转为uint8

    # 后续验证代码不变...

    # 6. 验证结果（打印M0/M1和分类结果）
    # 打印第一层自定义卷积的M0/M1（验证是否为整数）
    first_conv = model.features[0][0]
    print(f"\n第一层卷积的整数M0：{first_conv.M0_int.item()}")
    print(f"第一层卷积的整数M1：{first_conv.M1_int[:5].tolist()}...")  # 打印前5个偏置的M1

    # 打印分类结果（Top-1）
    with open("imagenet_classes.txt", "r") as f:
        categories = [s.strip() for s in f.readlines()]
    top1_idx = output.argmax(dim=1).item()
    print(f"\n分类结果：{categories[top1_idx]} (索引：{top1_idx})")

    return model, output


if __name__ == "__main__":
    # 运行主函数（需准备一张测试图像，如dog.jpg）
    # 若没有imagenet_classes.txt，可从这里下载：https://raw.githubusercontent.com/pytorch/hub/master/imagenet_classes.txt
    main()