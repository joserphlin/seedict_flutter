/// 音频信息模型
class AudioInfo {
  final String speaker;
  final String md5;

  AudioInfo({
    required this.speaker,
    required this.md5,
  });

  factory AudioInfo.fromJson(Map<String, dynamic> json) {
    return AudioInfo(
      speaker: json['speaker'] ?? '',
      md5: json['md5'] ?? '',
    );
  }
}

/// 音频响应模型
class AudioResponse {
  final String yngping;
  final List<AudioInfo> results;

  AudioResponse({
    required this.yngping,
    required this.results,
  });

  factory AudioResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AudioResponse(
      yngping: data['yngping'] ?? '',
      results: data['results'] != null
          ? (data['results'] as List)
              .map((item) => AudioInfo.fromJson(item))
              .toList()
          : [],
    );
  }
}
