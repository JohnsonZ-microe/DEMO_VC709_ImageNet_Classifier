def hex_str_to_reversed_bytes(hex_str):
    """
    将十六进制字符串按字节反转，返回二进制数据
    :param hex_str: 输入的十六进制字符串（无0x前缀）
    :return: 反转后的二进制bytes对象
    """
    # 检查字符串长度是否为偶数（确保能按字节拆分）
    if len(hex_str) % 2 != 0:
        raise ValueError("十六进制字符串长度必须是偶数！")

    # 按每2个字符拆分字节，反转列表后拼接
    bytes_list = [hex_str[i:i + 2] for i in range(0, len(hex_str), 2)]
    reversed_bytes_list = bytes_list[::-1]
    reversed_hex_str = ''.join(reversed_bytes_list)

    # 转成二进制数据并返回
    return bytes.fromhex(reversed_hex_str)


# 定义原始十六进制字符串
hex_str2 = "000000000000000000e80e7105103102"  # 第一段（你说的"第一行"）
hex_str1 = "00000000000000000000000303060dd9"  # 第二段（你说的"第二行"）

# 分别获取两段反转后的二进制数据
data2 = hex_str_to_reversed_bytes(hex_str2)
data1 = hex_str_to_reversed_bytes(hex_str1)

# 合并数据并写入同一个bin文件（先写data2，再写data1）
output_file = "combined_result.bin"
with open(output_file, "wb") as f:
    f.write(data2)  # 第一部分：0000e80e7105103102的反转结果
    f.write(data1)  # 第二部分：000000000303060dd9的反转结果

print(f"合并完成！数据已按顺序写入 {output_file}")
# 打印验证信息
print(f"第一段（0000e80e7105103102）反转后字节：{data2.hex().upper()}")
print(f"第二段（000000000303060dd9）反转后字节：{data1.hex().upper()}")