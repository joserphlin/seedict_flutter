# 🎉 米时典 SeeDict - Flutter 版本

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.22.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.4.0-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Proprietary-red)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-lightgrey)

**福州话词典移动应用**

[快速开始](#-快速开始) • [功能特性](#-功能特性) • [文档](#-文档) • [贡献](#-贡献)

</div>

---

## 📖 简介

米时典（SeeDict）Flutter 版本是一个跨平台的福州话词典应用，从原 Vue.js Web 应用完整迁移而来。支持 iOS、Android 和 Web 平台，提供丰富的词汇查询、学习和浏览功能。

## ✨ 功能特性

### 🏠 主页
- **滚动动画**: Logo 随滚动淡出和移动
- **智能搜索**: 带历史记录的搜索栏
- **词汇卡片**: 可滑动浏览的随机词汇
- **快速导航**: 便捷的导航面板

### 🔍 搜索
- **智能匹配**: 支持多种输入方式
- **历史记录**: 自动保存搜索历史
- **自动补全**: 实时过滤历史记录
- **分页加载**: 支持加载更多结果

### 📚 词汇详情
- **详细释义**: 完整的词汇解释
- **标准读音**: 音频播放支持
- **各地方音**: 不同地区读音对比
- **用字规范**: 标准用字说明

### 🎨 设计
- **精美界面**: 基于 Material Design
- **自定义主题**: 米时典专属配色
- **响应式布局**: 适配各种屏幕尺寸
- **流畅动画**: 优雅的交互体验

## 🚀 快速开始

### 前置要求
- Flutter SDK 3.22.1+
- Dart SDK 3.4.0+
- iOS/Android 开发环境（可选）

### 安装运行

```bash
# 1. 克隆项目
cd /Users/chenxian/projects/SeeDict/seedict_flutter

# 2. 安装依赖
flutter pub get

# 3. 运行应用
flutter run -d chrome  # Web
flutter run -d ios     # iOS
flutter run -d android # Android

# 或使用快速启动脚本
./run.sh
```

### 配置 API

```bash
# 方法 1: 命令行参数
flutter run --dart-define=API_URL=https://your-api.com

# 方法 2: 修改代码
# 编辑 lib/services/api_service.dart
```

详见 [CONFIG.md](CONFIG.md)

## 📁 项目结构

```
lib/
├── main.dart              # 应用入口
├── models/                # 数据模型
├── providers/             # 状态管理
├── screens/               # 页面
├── services/              # 服务层
├── widgets/               # 组件
├── router/                # 路由
└── utils/                 # 工具
```

## 🛠️ 技术栈

| 类别 | 技术 |
|-----|------|
| 框架 | Flutter 3.22.1 |
| 语言 | Dart 3.4.0 |
| 状态管理 | Provider |
| 路由 | GoRouter |
| 网络请求 | HTTP |
| 本地存储 | SharedPreferences |
| 音频播放 | AudioPlayers |

## 📚 文档

- [README.md](README.md) - 完整项目说明
- [QUICKSTART.md](QUICKSTART.md) - 快速开始指南
- [CONFIG.md](CONFIG.md) - 配置详细说明
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - 项目总结
- [CHECKLIST.md](CHECKLIST.md) - 完成清单

## 🎯 核心功能对比

| 功能 | Vue 版本 | Flutter 版本 | 状态 |
|-----|---------|-------------|------|
| 主页展示 | ✅ | ✅ | 完成 |
| 搜索功能 | ✅ | ✅ | 完成 |
| 词汇详情 | ✅ | ✅ | 完成 |
| 搜索历史 | ✅ | ✅ | 完成 |
| 词汇卡片 | ✅ | ✅ | 完成 |
| 音频播放 | ✅ | ⚠️ | 待完善 |
| 响应式设计 | ✅ | ✅ | 完成 |

## 🔧 开发命令

```bash
# 代码分析
flutter analyze

# 运行测试
flutter test

# 构建发布版
flutter build apk --release      # Android
flutter build ios --release      # iOS
flutter build web --release      # Web

# 清理项目
flutter clean
```

## 📱 支持平台

- ✅ iOS 14.0+
- ✅ Android 5.0+ (API 21+)
- ✅ Web (Chrome, Safari, Firefox)
- ⚠️ macOS (未测试)
- ⚠️ Windows (未测试)
- ⚠️ Linux (未测试)

## 🎨 主题颜色

```dart
// 小麦色系 (Wheat)
wheat50:  #FFFBF5
wheat300: #FDEC2
wheat500: #FBD799

// 玫瑰褐色系 (Rosy Brown)
rosyBrown50:  #FAF5F5
rosyBrown600: #AA5555
rosyBrown800: #6C3333
```

## 📊 项目统计

- **代码行数**: 3000+ 行
- **文件数量**: 20+ 个
- **组件数量**: 8 个
- **页面数量**: 5 个
- **依赖包数**: 10+ 个

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献指南
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

© 2024 SeeDict. All rights reserved.

## 📞 联系方式

- **反馈表单**: [点击这里](https://jcnf40n3hvft.feishu.cn/share/base/form/shrcnfDrtD7nlpJdryFlYFUU3Lf)
- **数据提交**: [点击这里](https://jcnf40n3hvft.feishu.cn/share/base/form/shrcnAQ3W3DjmPV7ycTJ1ekiFBf)
- **帮助文档**: [点击这里](https://jcnf40n3hvft.feishu.cn/docx/FSqidtsgjo25x0x6R1KcChopnTc)

## 🙏 致谢

感谢所有为福州话传承做出贡献的人！

---

<div align="center">

**用心传承，让福州话生生不息** ❤️

Made with ❤️ by SeeDict Team

</div>
