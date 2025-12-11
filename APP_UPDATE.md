# 🎨 应用名称和图标更新

## ✅ 更新内容

### 1. 应用名称
已将应用名称从 "SeeDict" / "seedict_flutter" 更改为 **"米时典"**。

- **Android**: `AndroidManifest.xml` 中的 `android:label` 已更新。
- **iOS**: `Info.plist` 中的 `CFBundleDisplayName` 和 `CFBundleName` 已更新。
- **Flutter**: `main.dart` 中的 `MaterialApp.title` 已更新。

### 2. 应用图标
已设计并替换了新的应用图标。

- **设计风格**: 简约、现代、扁平化。
- **配色**: 
  - 背景: Rosy Brown (#6C3333)
  - 前景: Wheat (#F5E6D3)
- **生成**: 使用 `flutter_launcher_icons` 自动生成了 Android 和 iOS 的所有尺寸图标。

## 📱 如何查看更改

由于涉及到原生资源的更改，**热重载 (Hot Reload) 无法应用这些更改**。您需要：

1. **停止当前运行的应用** (按 `q`)。
2. **重新运行应用**:
   ```bash
   flutter run
   ```
   或者重新构建 APK:
   ```bash
   flutter build apk --release
   ```

## ⚠️ 注意事项

- 如果在 Android 设备上图标或名称没有立即更新，请尝试**卸载应用**后重新安装。
- iOS 模拟器/真机同样需要重新构建安装。

更新完成！🎉
