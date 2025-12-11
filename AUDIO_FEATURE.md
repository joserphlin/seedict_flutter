# 🎵 音频播放功能说明

## ✅ 已实现功能

### 1. 音频数据模型
**文件**: `lib/models/audio_info.dart`

- `AudioInfo` - 单个音频信息
  - speaker: 说话人
  - md5: 音频文件标识
  
- `AudioResponse` - 音频API响应
  - yngping: 拼音
  - results: 音频列表

### 2. API 服务
**文件**: `lib/services/api_service.dart`

- `fetchAudioInfo(String yngping)` - 获取音频信息
  - 根据拼音查询可用音频
  - 返回音频列表
  
- `getAudioUrl(String speaker, String md5)` - 生成音频URL
  - 根据说话人和MD5生成完整URL
  - 格式: `{OSS_URL}/audio/{speaker}/{md5}.mp3`

### 3. 词汇详情页音频播放
**文件**: `lib/screens/word_screen.dart`

**功能**:
- ✅ 自动加载音频信息
- ✅ 播放/暂停控制
- ✅ 播放状态显示
- ✅ 加载状态指示
- ✅ 错误处理

**使用流程**:
1. 加载词汇详情
2. 自动获取音频信息（基于主要读音）
3. 显示播放按钮
4. 点击播放/暂停音频

## 🎯 功能特点

### 播放控制
- **播放**: 点击 🔊 图标开始播放
- **暂停**: 播放中点击 ⏸ 图标暂停
- **状态显示**: 图标根据播放状态自动切换

### 加载状态
- **加载中**: 显示圆形进度指示器
- **无音频**: 按钮变灰，显示"暂无音频"提示
- **有音频**: 按钮高亮，可点击播放

### 错误处理
- 音频加载失败不影响主要功能
- 播放失败显示错误提示
- 自动记录错误日志

## 📝 使用示例

### 在词汇详情页

```dart
// 1. 页面加载时自动获取音频
if (detail.pronPrimary.isNotEmpty) {
  _fetchAudioInfo(detail.pronPrimary);
}

// 2. 用户点击播放按钮
onPressed: _currentAudioUrl != null ? _playAudio : null

// 3. 播放/暂停切换
if (_isPlaying) {
  await _audioPlayer.pause();
} else {
  await _audioPlayer.play(UrlSource(_currentAudioUrl!));
}
```

## 🔧 技术实现

### 依赖包
```yaml
audioplayers: ^5.2.1
```

### 核心组件

#### AudioPlayer
```dart
final AudioPlayer _audioPlayer = AudioPlayer();

// 监听播放状态
_audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  setState(() {
    _isPlaying = state == PlayerState.playing;
  });
});
```

#### 状态管理
```dart
AudioResponse? _audioResponse;    // 音频信息
bool _isLoadingAudio = false;     // 加载状态
bool _isPlaying = false;          // 播放状态
String? _currentAudioUrl;         // 当前音频URL
```

## 🎨 UI 组件

### 音频按钮

```dart
// 加载中
CircularProgressIndicator()

// 可播放
IconButton(
  icon: Icon(_isPlaying ? Icons.pause_circle : Icons.volume_up),
  color: AppTheme.rosyBrown600,
  onPressed: _playAudio,
)

// 无音频
IconButton(
  icon: Icon(Icons.volume_up),
  color: AppTheme.rosyBrown300,  // 灰色
  onPressed: null,                // 禁用
)
```

## 📊 API 接口

### 获取音频信息
```
GET /api/v1/audio/?yngping={yngping}
```

**响应**:
```json
{
  "status": 200,
  "data": {
    "yngping": "dĕ̤ng",
    "results": [
      {
        "speaker": "hy",
        "md5": "abc123..."
      }
    ]
  }
}
```

### 音频文件URL
```
https://oss.seedict.com/audio/{speaker}/{md5}.mp3
```

## 🚀 未来改进

### 计划中的功能

1. **多音频源选择**
   - 显示所有可用说话人
   - 允许用户选择喜欢的说话人
   - 记住用户偏好

2. **播放控制增强**
   - 播放进度条
   - 播放速度调节
   - 循环播放

3. **离线缓存**
   - 缓存已播放音频
   - 离线播放支持
   - 缓存管理

4. **播放列表**
   - 连续播放多个词汇
   - 自动播放下一个
   - 播放历史

### 可选功能

1. **音频可视化**
   - 波形显示
   - 频谱分析

2. **录音对比**
   - 用户录音
   - 与标准音对比
   - 发音评分

3. **下载功能**
   - 下载音频文件
   - 分享音频

## 🐛 故障排除

### 音频无法播放

**可能原因**:
1. OSS URL 配置错误
2. 音频文件不存在
3. 网络连接问题
4. 音频格式不支持

**解决方案**:
1. 检查 OSS URL 配置
2. 验证音频文件存在
3. 检查网络连接
4. 确认音频格式为 MP3

### 音频加载慢

**优化方案**:
1. 使用音频预加载
2. 实现音频缓存
3. 优化音频文件大小
4. 使用 CDN 加速

## 📖 相关文档

- [AudioPlayers 文档](https://pub.dev/packages/audioplayers)
- [Flutter 音频播放指南](https://flutter.dev/docs/cookbook/plugins/play-video)

## ✅ 测试清单

- [ ] 音频信息加载
- [ ] 播放功能
- [ ] 暂停功能
- [ ] 状态切换
- [ ] 错误处理
- [ ] 加载状态显示
- [ ] 无音频提示

## 💡 使用提示

1. **首次播放可能较慢** - 需要下载音频文件
2. **建议使用耳机** - 获得更好的音质
3. **注意音量** - 避免音量过大
4. **网络环境** - 确保网络连接稳定

---

**状态**: ✅ 已完成
**版本**: 1.0.0
**更新时间**: 2024-12-10
