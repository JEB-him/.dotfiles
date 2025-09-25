#!/bin/bash

# 创建图片目录（如果不存在）
mkdir -p "$(pwd)/images"

# 生成文件名：当前日期 + 时间戳MD5前16位
filename="$(date +%Y%m%d)-$(date +%s | md5sum | head -c 16).png"

# 完整文件路径
filepath="$(pwd)/images/${filename}"

# 原本为了兼容使用了 xclip，但似乎不太稳定
# 使用 wl-paste 保存剪贴板图片（支持 PNG/JPG 格式）
if wl-paste --type image/png > "$filepath" 2>/dev/null; then
    echo "save to: $filepath"
elif wl-paste --type image/jpeg > "$filepath" 2>/dev/null; then
    echo "save to: $filepath"
else
    echo "剪贴板中没有图片数据！"
    exit 1
fi
