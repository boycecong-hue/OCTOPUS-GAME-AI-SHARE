#!/bin/bash

# 获取 .command 文件所在的绝对路径
BASE_DIR=$(cd "$(dirname "$0")"; pwd)
cd "$BASE_DIR"

# 设置颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 正在启动 AI Coding 技术分享会交互版...${NC}"

# 检查项目必要文件
if [ ! -f "index.html" ]; then
    echo "❌ 错误: 在 $BASE_DIR 中找不到 index.html"
    read -p "按回车键退出..."
    exit 1
fi

# 检查 python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未发现 python3，请确保已安装 Python。"
    read -p "按回车键退出..."
    exit 1
fi

PORT=8000
URL="http://localhost:$PORT/index.html"

echo -e "${GREEN}🔗 服务器已在后台启动: $URL${NC}"

# 启动后台服务器，抑制输出
python3 -m http.server $PORT > /dev/null 2>&1 &
SERVER_PID=$!

# 等待启动并自动打开浏览器
sleep 1
open "$URL"

echo -e "${BLUE}----------------------------------------${NC}"
echo -e "分享进行中... ${GREEN}请勿关闭此窗口${NC}，否则服务器将停止。"
echo -e "当你完成分享后，可以按 ${BLUE}Ctrl+C${NC} 或直接关闭此窗口。"
echo -e "${BLUE}----------------------------------------${NC}"

# 监听脚本关闭，同时关闭服务器
trap "kill $SERVER_PID; echo -e '\n👋 已停止服务器。'; exit" INT TERM EXIT
wait
