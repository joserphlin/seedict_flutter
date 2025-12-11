# API 配置说明

## 开发环境

### 本地开发 API
默认配置已设置为本地开发服务器：
```
http://localhost:8000/api/v1
```

### 启动本地 API 服务器
在运行 Flutter 应用之前，请确保后端 API 服务器正在运行。

如果您使用的是原 Vue 项目的后端：
```bash
# 在后端项目目录中
npm run dev
# 或
python manage.py runserver 8000
```

## 生产环境

### 使用命令行参数
```bash
flutter run --dart-define=API_URL=https://your-production-api.com/api/v1
```

### 构建时指定
```bash
flutter build apk --dart-define=API_URL=https://your-production-api.com/api/v1
```

## 常见问题

### 1. HandshakeException: Connection terminated during handshake

**原因**：
- API 地址配置错误
- 使用 HTTPS 但证书有问题
- API 服务器未启动

**解决方案**：
1. 确保 API 服务器正在运行
2. 检查 API 地址是否正确
3. 开发环境使用 HTTP 而非 HTTPS
4. 确保网络连接正常

### 2. Connection refused

**原因**：
- API 服务器未启动
- 端口号错误
- 防火墙阻止

**解决方案**：
1. 启动 API 服务器
2. 检查端口号（默认 8000）
3. 检查防火墙设置

### 3. iOS 模拟器无法连接 localhost

**原因**：
iOS 模拟器的 localhost 指向模拟器本身，而非宿主机

**解决方案**：
使用宿主机 IP 地址：
```bash
flutter run --dart-define=API_URL=http://192.168.1.100:8000/api/v1
```

或在代码中使用：
```dart
// iOS 模拟器使用宿主机 IP
defaultValue: Platform.isIOS 
    ? 'http://192.168.1.100:8000/api/v1'
    : 'http://localhost:8000/api/v1'
```

### 4. Android 模拟器无法连接 localhost

**原因**：
Android 模拟器的 localhost 指向模拟器本身

**解决方案**：
使用 Android 模拟器的特殊 IP：
```bash
flutter run --dart-define=API_URL=http://10.0.2.2:8000/api/v1
```

## 平台特定配置

### Web (Chrome)
```bash
# 直接使用 localhost
flutter run -d chrome
```

### iOS 模拟器
```bash
# 使用宿主机 IP（替换为您的实际 IP）
flutter run -d ios --dart-define=API_URL=http://192.168.1.100:8000/api/v1
```

### Android 模拟器
```bash
# 使用 Android 特殊 IP
flutter run -d android --dart-define=API_URL=http://10.0.2.2:8000/api/v1
```

### 真机测试
```bash
# 使用宿主机在局域网中的 IP
flutter run --dart-define=API_URL=http://192.168.1.100:8000/api/v1
```

## 环境变量优先级

1. 命令行参数 `--dart-define=API_URL=...` （最高优先级）
2. 代码中的 `defaultValue`
3. 如果都未设置，使用默认值

## 快速测试

### 测试 API 连接
```bash
# 在终端中测试
curl http://localhost:8000/api/v1/shuffle/

# 如果返回 JSON 数据，说明 API 正常
```

## 推荐配置

### 开发阶段
```dart
defaultValue: 'http://localhost:8000/api/v1'
```

### 测试阶段
```bash
flutter run --dart-define=API_URL=https://test-api.seedict.com/api/v1
```

### 生产阶段
```bash
flutter build apk --dart-define=API_URL=https://api.seedict.com/api/v1
```
