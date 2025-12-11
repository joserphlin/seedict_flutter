#!/bin/bash

# 米时典 Flutter 快速启动脚本

echo "🎯 米时典 SeeDict Flutter 版本"
echo "================================"
echo ""

# 检查 Flutter 是否安装
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装，请先安装 Flutter SDK"
    echo "   访问: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter 已安装"
flutter --version
echo ""

# 检查依赖
echo "📦 检查依赖..."
if [ ! -d ".dart_tool" ]; then
    echo "   首次运行，正在安装依赖..."
    flutter pub get
else
    echo "   依赖已安装"
fi
echo ""

# 显示可用设备
echo "📱 可用设备:"
flutter devices
echo ""

# 询问运行平台
echo "请选择运行平台:"
echo "1) iOS 模拟器"
echo "2) Android 模拟器"
echo "3) Chrome 浏览器"
echo "4) 查看所有设备"
echo "5) 退出"
echo ""

read -p "请输入选项 (1-5): " choice

case $choice in
    1)
        echo "🚀 正在启动 iOS 模拟器..."
        flutter run -d ios
        ;;
    2)
        echo "🚀 正在启动 Android 模拟器..."
        flutter run -d android
        ;;
    3)
        echo "🚀 正在启动 Chrome 浏览器..."
        flutter run -d chrome
        ;;
    4)
        echo "📱 所有可用设备:"
        flutter devices -v
        echo ""
        read -p "请输入设备 ID: " device_id
        flutter run -d "$device_id"
        ;;
    5)
        echo "👋 再见！"
        exit 0
        ;;
    *)
        echo "❌ 无效选项"
        exit 1
        ;;
esac
