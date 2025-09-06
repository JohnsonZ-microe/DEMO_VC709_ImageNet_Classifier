import torch
import torchvision as tv
from torch.utils.data import DataLoader
from torchvision import datasets, transforms
from tqdm import tqdm

# ========= 数据 =========
DATA_DIR = '/shares/Databases/ImageNet/val'   # 改成你的 val 路径
BATCH_SIZE = 128
NUM_WORKERS = 8
device = torch.device('cpu')

preprocess = transforms.Compose([
    transforms.Resize(256, antialias=True),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])
val_dataset = datasets.ImageFolder(root=DATA_DIR, transform=preprocess)
val_loader = DataLoader(val_dataset, batch_size=BATCH_SIZE, shuffle=False,
                        num_workers=NUM_WORKERS, pin_memory=False)

# ========= 浮点模型 =========
weights = tv.models.MobileNet_V2_Weights.IMAGENET1K_V1
float_model = tv.models.mobilenet_v2(weights=weights).eval()

# ========= FX 量化准备 =========
from torch.ao.quantization import get_default_qconfig
from torch.ao.quantization.quantize_fx import prepare_fx, convert_fx

torch.backends.quantized.engine = "fbgemm"
qconfig = get_default_qconfig("fbgemm")
example_input = torch.randn(1, 3, 224, 224)

# 尝试导入 reference backend；失败则走 fallback: lower_to_reference
use_ref_backend_cfg = True
try:
    from torch.ao.quantization.backend_config import get_reference_backend_config
    backend_config = get_reference_backend_config()
except Exception:
    use_ref_backend_cfg = False
    backend_config = None

prepared = prepare_fx(
    float_model, {"": qconfig},
    example_inputs=example_input,
    backend_config=backend_config  # 旧版本这里会是 None -> 仍可正常准备
).eval()

# 简单校准
with torch.inference_mode():
    it = 0
    for images, _ in val_loader:
        prepared(images)
        it += 1
        if it >= 10:
            break

converted = convert_fx(prepared, backend_config=backend_config).eval()

# 如果没有 reference backend config，就把模型降到 reference 表示
if not use_ref_backend_cfg:
    # 旧版本路径
    try:
        from torch.ao.quantization.fx.lower_to_reference import lower_to_reference
    except Exception:
        # 更老的私有路径（如果上面失败再试这个）
        from torch.ao.quantization.fx._lower_to_reference import lower_to_reference
    converted_ref = lower_to_reference(converted).eval()
else:
    # 新版本直接已经是 reference 图
    converted_ref = converted

# ========= 定义整数 M0/n 的 requantize 并替换图 =========
import torch.fx as fx
from torch.fx import GraphModule

def int_requant_per_tensor(x_int32, s_in, zp_in, s_out, zp_out, qmin, qmax):
    n = 31
    M0 = torch.round((s_in / s_out) * (1 << n)).to(torch.int64)
    x = x_int32.to(torch.int64)
    rounding = (1 << (n - 1))
    y = (x * M0 + rounding) >> n
    y = y + zp_out.to(torch.int64)
    y = torch.clamp(y, int(qmin), int(qmax))
    return y.to(torch.int8)

def int_requant_per_channel(x_int32, s_in, zp_in, s_out, zp_out, axis, qmin, qmax):
    n = 31
    M0 = torch.round((s_in / s_out) * (1 << n)).to(torch.int64)  # shape: [C]
    x = x_int32.to(torch.int64)
    rounding = (1 << (n - 1))
    view_shape = [1] * x.ndim
    view_shape[axis] = -1
    M0v = M0.view(view_shape)
    zp_out_v = zp_out.to(torch.int64).view(view_shape)
    y = (x * M0v + rounding) >> n
    y = y + zp_out_v
    y = torch.clamp(y, int(qmin), int(qmax))
    return y.to(torch.int8)

def _is_requant_per_tensor(node):
    tgt = node.target
    return (
        tgt == torch.ops.quantized_decomposed.requantize_per_tensor.default
        or str(tgt).endswith("quantized_decomposed::requantize_per_tensor.default")
        or str(tgt).endswith("quantized_decomposed::requantize_per_tensor")
    )

def _is_requant_per_channel(node):
    tgt = node.target
    return (
        tgt == torch.ops.quantized_decomposed.requantize_per_channel.default
        or str(tgt).endswith("quantized_decomposed::requantize_per_channel.default")
        or str(tgt).endswith("quantized_decomposed::requantize_per_channel")
    )

def rewrite_requant_nodes(gm: GraphModule) -> GraphModule:
    g = gm.graph
    for node in list(g.nodes):
        if _is_requant_per_tensor(node):
            x, s_in, zp_in, s_out, zp_out, qmin, qmax = node.args
            with g.inserting_after(node):
                new_node = g.call_function(int_requant_per_tensor,
                                           (x, s_in, zp_in, s_out, zp_out, qmin, qmax))
            node.replace_all_uses_with(new_node)
            g.erase_node(node)
        elif _is_requant_per_channel(node):
            x, s_in, zp_in, s_out, zp_out, axis, qmin, qmax = node.args
            with g.inserting_after(node):
                new_node = g.call_function(int_requant_per_channel,
                                           (x, s_in, zp_in, s_out, zp_out, axis, qmin, qmax))
            node.replace_all_uses_with(new_node)
            g.erase_node(node)
    g.lint()
    gm.recompile()
    return gm

modified = rewrite_requant_nodes(converted_ref).eval()

# ========= 评测 =========
@torch.inference_mode()
def evaluate(model, loader):
    model.eval()
    top1 = 0
    top5 = 0
    total = 0
    for images, labels in tqdm(loader, desc="Evaluating (int M0/n requant)"):
        logits = model(images)  # CPU
        pred1 = logits.argmax(dim=1)
        top1 += (pred1 == labels).sum().item()
        _, pred5 = logits.topk(5, dim=1, largest=True, sorted=True)
        top5 += pred5.eq(labels.view(-1, 1)).sum().item()
        total += labels.size(0)
    return 100.0 * top1 / total, 100.0 * top5 / total

if __name__ == "__main__":
    t1, t5 = evaluate(modified, val_loader)
    print(f"Top-1: {t1:.2f}%  Top-5: {t5:.2f}%")
