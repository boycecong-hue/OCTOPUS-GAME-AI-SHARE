#!/bin/bash

# 检查是否安装了 python3
if ! command -v python3 &> /dev/null
then
    echo "未发现 python3，请确保已安装 Python。"
    exit
fi

echo "🚀 正在启动 AI Coding 技术分享会本地服务器..."
echo "🔗 访问地址: http://localhost:8000/index.html"

# 启动后台服务器
python3 -m http.server 8000 &
SERVER_PID=$!

# 等待一秒确保服务器启动
sleep 1

# 自动打开浏览器 (仅限 macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "http://localhost:8000/index.html"
else
    echo "请手动在浏览器中打开: http://localhost:8000/index.html"
fi

# 监听脚本关闭，同时关闭服务器
trap "kill $SERVER_PID" EXIT
wait
