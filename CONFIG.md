# 米时典 Flutter 配置说明

## API 配置

### 开发环境
默认 API 地址：https://api.seedict.com
默认 OSS 地址：https://oss.seedict.com

### 自定义配置

#### 方法 1: 使用命令行参数
```bash
flutter run --dart-define=API_URL=https://your-api.com --dart-define=OSS_URL=https://your-oss.com
```

#### 方法 2: 修改源代码
编辑 `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'https://your-api.com';
```

## 运行项目

### 检查 Flutter 环境
```bash
flutter doctor
```

### 获取依赖
```bash
flutter pub get
```

### 运行开发版本
```bash
# iOS
flutter run -d ios

# Android  
flutter run -d android

# Web
flutter run -d chrome
```

### 构建发布版本
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 常见问题

### 1. 依赖安装失败
```bash
flutter pub cache repair
flutter pub get
```

### 2. iOS 构建失败
```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### 3. Android 构建失败
确保已安装 Android SDK 和配置好环境变量

### 4. API 请求失败
检查 API 地址配置是否正确，网络是否正常

## 开发建议

1. 使用 VS Code 或 Android Studio 进行开发
2. 安装 Flutter 和 Dart 插件
3. 启用热重载功能提高开发效率
4. 使用 `flutter analyze` 检查代码质量
