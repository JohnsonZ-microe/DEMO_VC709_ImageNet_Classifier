import os
import pickle
import random

import cupy as cp
import numpy as np
import torch
import torchvision
from torch.utils.data import DataLoader
from torch.utils.data import Subset
from torchvision import datasets, transforms
from tqdm import tqdm

from MobileNetV2_numpy import numpy_inference
# 加载之前保存的量化参数
M0_int_n_list = np.load("M0_int_n_list.npy")
M0_SC_int_n_list = np.load("M0_SC_int_n_list.npy")
M1_SC_int_n_list = np.load("M1_SC_int_n_list.npy")
with open("M1_list.pkl", 'rb') as f:
    M1_list = pickle.load(f)

# 加载量化MobileNetV2模型（仅用于获取权重）
device = torch.device("cpu")
model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True).to(device)
model_quantized.eval()

# 定义预处理
normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                 std=[0.229, 0.224, 0.225])
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    normalize,
])

# 加载ImageNet验证集
val_dir = "/shares/Databases/ImageNet/val"  # 替换为您的ImageNet验证集路径
val_dataset = datasets.ImageFolder(val_dir, transform=preprocess)
total_size = len(val_dataset)
num_images_to_test = 50000
random_indices = random.sample(range(total_size), num_images_to_test)
val_subset = Subset(val_dataset, random_indices)
val_loader = DataLoader(
    val_subset,
    batch_size=128,
    shuffle=False,
    num_workers=8,
    pin_memory=True
)
# 加载类别名称
with open("imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]

# 初始化统计变量
top1_correct = 0
top5_correct = 0
total_samples = 0
results = []

# 创建保存结果的目录
os.makedirs("validation_results", exist_ok=True)
image_index = 0
# 验证循环
for images, labels in tqdm(val_loader, desc="Validating"):
    # 将数据转移到CPU
    images = images.to(device)
    labels = labels.to(device)

    # 使用numpy模型推理
    batch_logits = []
    for i in range(images.size(0)):
        image_index = image_index + 1
        single_image = images[i].unsqueeze(0)  # 保持批次维度
        # print('\nInference start:%d'%image_index)
        logits = numpy_inference(single_image)
        batch_logits.append(logits)

    # 转换为tensor
    logits_tensor = torch.tensor(np.array(batch_logits))

    # 计算准确率
    _, preds = torch.topk(logits_tensor, 5, dim=1)
    correct_top1 = preds[:, 0] == labels
    correct_top5 = torch.any(preds == labels.unsqueeze(1), dim=1)

    # 更新统计
    top1_correct += correct_top1.sum().item()
    top5_correct += correct_top5.sum().item()
    total_samples += labels.size(0)

    # 保存结果用于后续分析
    for i in range(labels.size(0)):
        results.append({
            "true_label": labels[i].item(),
            "pred_top1": preds[i, 0].item(),
            "pred_top5": preds[i].tolist(),
            "correct_top1": correct_top1[i].item(),
            "correct_top5": correct_top5[i].item()
        })

    # 定期保存中间结果
    if total_samples % 1000 == 0:
        print(f"\nProcessed {total_samples} samples | "
              f"Top-1 Acc: {top1_correct / total_samples:.4f} | "
              f"Top-5 Acc: {top5_correct / total_samples:.4f}")

        # 保存检查点
        checkpoint = {
            "results": results,
            "top1_correct": top1_correct,
            "top5_correct": top5_correct,
            "total_samples": total_samples
        }
        torch.save(checkpoint, f"validation_results/checkpoint_{total_samples}.pth")

# 最终结果
top1_acc = top1_correct / total_samples
top5_acc = top5_correct / total_samples
print("\nValidation Complete!")
print(f"Top-1 Accuracy: {top1_acc:.4f}")
print(f"Top-5 Accuracy: {top5_acc:.4f}")

# 保存最终结果
final_results = {
    "top1_accuracy": top1_acc,
    "top5_accuracy": top5_acc,
    "total_samples": total_samples,
    "detailed_results": results
}
torch.save(final_results, "validation_results/final_results.pth")

# 分析各类别准确率
from collections import defaultdict

class_stats = defaultdict(lambda: {"count": 0, "top1_correct": 0, "top5_correct": 0})

for result in results:
    class_id = result["true_label"]
    class_stats[class_id]["count"] += 1
    class_stats[class_id]["top1_correct"] += result["correct_top1"]
    class_stats[class_id]["top5_correct"] += result["correct_top5"]

# 保存类别统计
class_accuracies = []
for class_id, stats in class_stats.items():
    top1_acc = stats["top1_correct"] / stats["count"]
    top5_acc = stats["top5_correct"] / stats["count"]
    class_accuracies.append({
        "class_id": class_id,
        "class_name": categories[class_id],
        "top1_accuracy": top1_acc,
        "top5_accuracy": top5_acc,
        "sample_count": stats["count"]
    })

# 按准确率排序
class_accuracies.sort(key=lambda x: x["top1_accuracy"])

# 保存类别统计结果
torch.save(class_accuracies, "validation_results/class_accuracies.pth")

# 打印最差表现的10个类别
print("\nTop 10 Worst Performing Classes:")
for class_info in class_accuracies[:10]:
    print(f"{class_info['class_name']} (ID: {class_info['class_id']}):")
    print(f"  Top-1: {class_info['top1_accuracy']:.4f}")
    print(f"  Top-5: {class_info['top5_accuracy']:.4f}")
    print(f"  Samples: {class_info['sample_count']}")