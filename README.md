# 米时典 SeeDict - Flutter 版本

这是米时典（SeeDict）福州话词典的 Flutter 移动应用版本，从原 Vue.js Web 应用移植而来。

## 功能特性

- ✅ **主页**: 带滚动动画的 Logo、搜索栏和可滑动的词汇卡片
- ✅ **搜索功能**: 智能搜索带历史记录、自动补全和分页加载
- ✅ **词汇详情**: 显示详细的词汇信息，包括释义、读音、用字等
- ✅ **导航**: 主页、入门教程、帮助、关于等页面
- ✅ **状态管理**: 使用 Provider 进行状态管理
- ✅ **本地存储**: 搜索历史持久化存储
- ✅ **响应式设计**: 适配不同屏幕尺寸

## 技术栈

- **Flutter**: 跨平台 UI 框架
- **Provider**: 状态管理
- **GoRouter**: 路由管理
- **SharedPreferences**: 本地数据存储
- **HTTP**: 网络请求
- **AudioPlayers**: 音频播放（待实现）

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── models/                   # 数据模型
│   ├── word.dart
│   ├── search_result.dart
│   └── word_detail.dart
├── providers/                # 状态管理
│   ├── deck_provider.dart
│   └── search_provider.dart
├── screens/                  # 页面
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── word_screen.dart
│   ├── about_screen.dart
│   └── tutorial_screen.dart
├── services/                 # 服务层
│   ├── api_service.dart
│   └── search_history_service.dart
├── widgets/                  # 组件
│   ├── search_bar.dart
│   ├── words_deck.dart
│   └── nav_panel.dart
├── router/                   # 路由配置
│   └── app_router.dart
└── utils/                    # 工具类
    └── theme.dart
```

## 开始使用

### 前置要求

- Flutter SDK (3.22.1 或更高版本)
- Dart SDK (3.4.0 或更高版本)
- Android Studio / Xcode (用于移动端开发)
- VS Code 或其他 IDE

### 安装步骤

1. **克隆项目**
   ```bash
   cd /Users/chenxian/projects/SeeDict/seedict_flutter
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **配置 API 地址**
   
   在运行前，需要配置 API 地址。有两种方式：
   
   **方式一：使用环境变量**
   ```bash
   flutter run --dart-define=API_URL=https://your-api-url.com
   ```
   
   **方式二：修改代码**
   
   编辑 `lib/services/api_service.dart`，修改 `baseUrl` 的默认值：
   ```dart
   static const String baseUrl = 'https://your-api-url.com';
   ```

4. **运行应用**
   
   **iOS 模拟器**
   ```bash
   flutter run -d ios
   ```
   
   **Android 模拟器**
   ```bash
   flutter run -d android
   ```
   
   **Web 浏览器**
   ```bash
   flutter run -d chrome
   ```

### 构建发布版本

**Android APK**
```bash
flutter build apk --release
```

**iOS IPA**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## API 接口

应用需要以下 API 接口：

- `GET /shuffle/` - 获取随机词汇卡片
- `GET /search/?q={query}&cursor={cursor}` - 搜索词汇
- `GET /word/?w={word}` - 获取词汇详情
- `GET /audio/?yngping={yngping}` - 获取音频信息

## 待实现功能

- [ ] 音频播放功能完善
- [ ] 离线缓存
- [ ] 收藏功能
- [ ] 学习进度跟踪
- [ ] 深色模式
- [ ] 多语言支持
- [ ] 分享功能

## 与原 Vue 项目的对应关系

| Vue 组件 | Flutter 组件 |
|---------|-------------|
| HomeView.vue | home_screen.dart |
| SearchView.vue | search_screen.dart |
| WordView.vue | word_screen.dart |
| SearchBar.vue | search_bar.dart |
| WordsDeck.vue | words_deck.dart |
| NavPanel.vue | nav_panel.dart |
| deckStore.ts | deck_provider.dart |
| apiService | api_service.dart |

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

© 2024 SeeDict. All rights reserved.

## 联系方式

如有问题或建议，请通过以下方式联系：

- 反馈表单: https://jcnf40n3hvft.feishu.cn/share/base/form/shrcnfDrtD7nlpJdryFlYFUU3Lf
- 数据提交: https://jcnf40n3hvft.feishu.cn/share/base/form/shrcnAQ3W3DjmPV7ycTJ1ekiFBf
