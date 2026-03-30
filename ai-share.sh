#!/bin/bash

# 获取项目根目录（硬编码为你当前的绝对路径）
PROJECT_DIR="/Users/boycecong/Documents/技术文档/公司AI技术分享会"

# 检查项目目录是否存在
if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ 错误: 找不到项目目录 $PROJECT_DIR"
    exit 1
fi

cd "$PROJECT_DIR"

# 检查 python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未发现 python3，请确保已安装 Python。"
    exit 1
fi

PORT=8000
URL="http://localhost:$PORT/index.html"

echo "🚀 正在启动 AI Coding 技术分享会 (Command Mode)..."
echo "🔗 访问地址: $URL"

# 启动后台服务器，抑制输出
python3 -m http.server $PORT > /dev/null 2>&1 &
SERVER_PID=$!

# 等待启动并打开浏览器
sleep 1
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$URL"
else
    echo "请手动在浏览器中打开: $URL"
fi

# 保持进程运行，直到用户按下 Ctrl+C
echo "按下 Ctrl+C 停止分享并关闭服务器。"
trap "kill $SERVER_PID; echo -e '\n👋 已停止服务器。'; exit" INT
wait
