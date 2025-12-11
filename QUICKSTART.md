# 🎯 米时典 Flutter 版本 - 快速开始指南

## 📁 项目结构

```
seedict_flutter/
├── lib/
│   ├── main.dart                    # 应用入口
│   ├── models/                      # 数据模型
│   │   ├── word.dart               # 词汇模型
│   │   ├── search_result.dart      # 搜索结果模型
│   │   └── word_detail.dart        # 词汇详情模型
│   ├── providers/                   # 状态管理
│   │   ├── deck_provider.dart      # 卡片状态
│   │   └── search_provider.dart    # 搜索状态
│   ├── screens/                     # 页面
│   │   ├── home_screen.dart        # 主页
│   │   ├── search_screen.dart      # 搜索页
│   │   ├── word_screen.dart        # 词汇详情页
│   │   ├── about_screen.dart       # 关于页
│   │   └── tutorial_screen.dart    # 教程页
│   ├── services/                    # 服务层
│   │   ├── api_service.dart        # API 服务
│   │   └── search_history_service.dart  # 搜索历史
│   ├── widgets/                     # 组件
│   │   ├── search_bar.dart         # 搜索栏
│   │   ├── words_deck.dart         # 词汇卡片
│   │   └── nav_panel.dart          # 导航面板
│   ├── router/                      # 路由
│   │   └── app_router.dart         # 路由配置
│   └── utils/                       # 工具
│       └── theme.dart              # 主题配置
├── assets/                          # 资源文件
├── CONFIG.md                        # 配置说明
├── PROJECT_SUMMARY.md               # 项目总结
├── README.md                        # 项目说明
└── run.sh                          # 快速启动脚本
```

## 🚀 快速开始

### 方法 1: 使用启动脚本（推荐）

```bash
cd /Users/chenxian/projects/SeeDict/seedict_flutter
./run.sh
```

脚本会自动：
- ✅ 检查 Flutter 环境
- ✅ 安装依赖
- ✅ 显示可用设备
- ✅ 启动应用

### 方法 2: 手动运行

```bash
# 1. 进入项目目录
cd /Users/chenxian/projects/SeeDict/seedict_flutter

# 2. 安装依赖
flutter pub get

# 3. 运行应用
flutter run -d chrome  # Web
# 或
flutter run -d ios     # iOS
# 或
flutter run -d android # Android
```

## ⚙️ 配置 API

### 临时配置（推荐用于测试）
```bash
flutter run --dart-define=API_URL=https://your-api.com
```

### 永久配置
编辑 `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'https://your-api.com';
```

## 📱 核心功能

### 1. 主页
- 🎨 滚动动画效果
- 🔍 智能搜索栏
- 🎴 可滑动词汇卡片
- 🧭 导航面板

### 2. 搜索
- 📝 搜索历史记录
- 🔄 自动补全
- 📄 分页加载
- 💾 本地存储

### 3. 词汇详情
- 📖 详细释义
- 🎵 读音展示
- 🌏 各地方音
- ✍️ 用字规范

## 🛠️ 开发命令

```bash
# 检查环境
flutter doctor

# 安装依赖
flutter pub get

# 代码分析
flutter analyze

# 运行测试
flutter test

# 清理项目
flutter clean

# 构建发布版
flutter build apk --release      # Android
flutter build ios --release      # iOS
flutter build web --release      # Web
```

## 📦 依赖包

| 包名 | 版本 | 用途 |
|-----|------|-----|
| provider | ^6.1.1 | 状态管理 |
| go_router | ^13.0.0 | 路由管理 |
| http | ^1.2.0 | HTTP 请求 |
| shared_preferences | ^2.2.2 | 本地存储 |
| audioplayers | ^5.2.1 | 音频播放 |
| url_launcher | ^6.2.4 | 打开链接 |
| flutter_animate | ^4.5.0 | 动画效果 |

## 🎨 主题颜色

```dart
// 小麦色系
wheat50  = #FFFBF5
wheat100 = #FFF7EB
wheat300 = #FDEC2
wheat500 = #FBD799

// 玫瑰褐色系
rosyBrown50  = #FAF5F5
rosyBrown300 = #D7AFAF
rosyBrown600 = #AA5555
rosyBrown800 = #6C3333
```

## 📝 代码规范

- 使用 `const` 构造函数优化性能
- 遵循 Dart 命名规范
- 添加必要的注释
- 保持代码整洁

## 🐛 常见问题

### Q: 运行时提示找不到设备？
A: 运行 `flutter devices` 查看可用设备，或启动模拟器

### Q: 依赖安装失败？
A: 运行 `flutter pub cache repair` 然后重新 `flutter pub get`

### Q: API 请求失败？
A: 检查 API 地址配置和网络连接

### Q: iOS 构建失败？
A: 进入 ios 目录运行 `pod install`

## 📚 相关文档

- [README.md](README.md) - 项目完整说明
- [CONFIG.md](CONFIG.md) - 配置详细指南
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - 项目总结

## 🎯 下一步

1. ✅ 配置正确的 API 地址
2. ✅ 添加实际的 Logo 图片到 `assets/`
3. ✅ 测试所有功能
4. ✅ 根据需要调整样式
5. ✅ 构建发布版本

## 💡 提示

- 使用热重载 (`r`) 快速查看更改
- 使用热重启 (`R`) 重置应用状态
- 按 `q` 退出应用
- 按 `h` 查看帮助

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

**祝您使用愉快！** 🎉

如有问题，请查看 [README.md](README.md) 或提交 Issue。
