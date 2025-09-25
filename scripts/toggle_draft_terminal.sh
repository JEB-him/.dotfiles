#!/bin/bash

# 设置终端类名
CLASS_NAME="DraftTerminal"

# 获取当前工作区ID
ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

# 检查当前工作区是否存在指定类名的窗口
CURRENT_TERMS=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${CLASS_NAME}\" and .workspace.id == ${ACTIVE_WORKSPACE}) | .address")

# 去除空白行并转换为数组
readarray -t CURRENT_TERMS_ARRAY <<< "${CURRENT_TERMS}"

if [ ${#CURRENT_TERMS_ARRAY[@]} -gt 0 ] && [ -n "${CURRENT_TERMS_ARRAY[0]}" ]; then
    echo "当前工作区中存在 ${CLASS_NAME}，执行隐藏操作..."
    
    # 隐藏操作：取消pin并移动到hidden工作区
    for address in "${CURRENT_TERMS_ARRAY[@]}"; do
        if [ -n "$address" ]; then
            echo "隐藏窗口: $address"
            hyprctl dispatch pin "address:$address"
            hyprctl dispatch movetoworkspacesilent special:hidden, address:$address
        fi
    done
else
    echo "当前工作区中不存在 ${CLASS_NAME}，执行显示操作..."
    
    # 显示操作：检查其他工作区是否有指定类名的窗口
    OTHER_TERMS=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${CLASS_NAME}\" and .workspace.id != ${ACTIVE_WORKSPACE}) | .address")
    
    readarray -t OTHER_TERMS_ARRAY <<< "${OTHER_TERMS}"
    
    if [ ${#OTHER_TERMS_ARRAY[@]} -gt 0 ] && [ -n "${OTHER_TERMS_ARRAY[0]}" ]; then
        # 存在其他工作区的窗口，移动到当前工作区
        echo "发现其他工作区的 ${CLASS_NAME}，移动到当前工作区..."
        for address in "${OTHER_TERMS_ARRAY[@]}"; do
            if [ -n "$address" ]; then
                echo "移动窗口到当前工作区: $address"
                hyprctl dispatch movetoworkspacesilent ${ACTIVE_WORKSPACE}, address:$address
                hyprctl dispatch pin "address:$address"
                hyprctl dispatch focuswindow "address:$address"
                hyprctl dispatch resizeactive exact 50% 50% "address:$address"
            fi
        done
    else
        # 不存在任何窗口，创建新窗口
        echo "创建新的 ${CLASS_NAME}..."
        kitty --class="$CLASS_NAME" &
        
        # 等待窗口创建
        sleep 0.5
        
        # 获取新创建的窗口地址
        NEW_TERM=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${CLASS_NAME}\") | .address" | head -n1)
        
        if [ -n "$NEW_TERM" ]; then
            echo "设置新窗口属性: $NEW_TERM"
            hyprctl dispatch pin "address:$NEW_TERM"
            hyprctl dispatch resizeactive exact 50% 50% "address:$NEW_TERM"
            hyprctl dispatch centerwindow "address:$NEW_TERM"
        else
            echo "警告: 未能找到新创建的窗口"
        fi
    fi
fi
