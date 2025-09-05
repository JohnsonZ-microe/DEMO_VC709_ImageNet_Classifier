import torch
import torchvision
from torchvision import datasets, transforms
from tqdm import tqdm
import os

# 配置参数
DATA_DIR = '/shares/Databases/ImageNet/val'  # ImageNet验证集路径
BATCH_SIZE = 128
NUM_WORKERS = 8

device = torch.device('cpu')
# 设备设置
# 预处理
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406],
                         std=[0.229, 0.224, 0.225]),
])

# 加载验证集
val_dataset = datasets.ImageFolder(
    root=DATA_DIR,
    transform=preprocess
)
val_loader = torch.utils.data.DataLoader(
    val_dataset,
    batch_size=BATCH_SIZE,
    shuffle=False,
    num_workers=NUM_WORKERS,
    pin_memory=True
)

# 加载预训练模型
model = torchvision.models.quantization.mobilenet_v2(pretrained=True,
                                                               quantize=True).to('cpu')

model.eval()  # 设置为评估模式


# 评估函数
def evaluate():
    correct_top1 = 0
    correct_top5 = 0
    total = 0

    with torch.no_grad():
        for images, labels in tqdm(val_loader, desc="Evaluating"):
            images = images.to(device)
            labels = labels.to(device)

            outputs = model(images)

            # Top-1准确率
            _, preds_top1 = torch.max(outputs, 1)
            correct_top1 += torch.sum(preds_top1 == labels).item()

            # Top-5准确率
            _, preds_top5 = outputs.topk(5, 1, True, True)
            correct_top5 += torch.eq(preds_top5, labels.view(-1, 1)).sum().item()

            total += labels.size(0)

    top1_acc = 100. * correct_top1 / total
    top5_acc = 100. * correct_top5 / total
    return top1_acc, top5_acc


# 运行评估
if __name__ == "__main__":
    print("Starting evaluation...")
    top1, top5 = evaluate()
    print(f"\nEvaluation complete!")
    print(f"Top-1 Accuracy: {top1:.2f}%")
    print(f"Top-5 Accuracy: {top5:.2f}%")