#!/bin/bash
cd "$(dirname "$0")"

IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

# 找一个可用端口
PORT=8080
while lsof -i :$PORT &>/dev/null; do
  PORT=$((PORT + 1))
  if [ $PORT -gt 8090 ]; then
    echo "端口都被占用了，换个姿势再来吧"
    read -p "按回车退出"
    exit 1
  fi
done

echo ""
echo "================================"
echo "  自我探索 · ${PORT}"
echo "================================"
echo ""
echo "  手机 Safari 输入:"
echo "  http://${IP}:${PORT}/自我探索.html"
echo ""
echo "  电脑浏览器打开:"
echo "  http://localhost:${PORT}/自我探索.html"
echo ""
echo "  关掉终端或 Ctrl+C 停止"
echo "================================"
echo ""

python3 -m http.server $PORT

if [ $? -ne 0 ]; then
  read -p "启动失败，按回车退出"
fi
