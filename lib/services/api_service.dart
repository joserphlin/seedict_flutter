import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/word.dart';
import '../models/search_result.dart';
import '../models/word_detail.dart';
import '../models/audio_info.dart';

class ApiService {
  // 使用环境变量或默认值
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://seedict.com/api/v1', // 替换为实际的 API 地址
  );

  /// 获取随机词汇卡片
  Future<List<Word>> fetchDeck() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shuffle/'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 200 && data['data']?['randomWords'] != null) {
          return (data['data']['randomWords'] as List)
              .map((item) => Word.fromJson(item))
              .toList();
        }
      }
      throw Exception('Failed to load deck');
    } catch (e) {
      throw Exception('Error fetching deck: $e');
    }
  }

  /// 搜索词汇
  Future<SearchResponse> search(String query, {String? cursor}) async {
    try {
      final params = {'q': query};
      if (cursor != null) {
        params['cursor'] = cursor;
      }

      final uri =
          Uri.parse('$baseUrl/search/').replace(queryParameters: params);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return SearchResponse.fromJson(data);
      }
      throw Exception('Failed to search');
    } catch (e) {
      throw Exception('Error searching: $e');
    }
  }

  /// 获取词汇详情
  Future<WordDetailResponse> fetchWordDetail(String w) async {
    try {
      final uri =
          Uri.parse('$baseUrl/word/').replace(queryParameters: {'w': w});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WordDetailResponse.fromJson(data);
      }
      throw Exception('Failed to load word detail');
    } catch (e) {
      throw Exception('Error fetching word detail: $e');
    }
  }

  /// 获取音频信息
  Future<AudioResponse> fetchAudioInfo(String yngping) async {
    try {
      final uri = Uri.parse('$baseUrl/audio/')
          .replace(queryParameters: {'yngping': yngping});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AudioResponse.fromJson(data);
      }
      throw Exception('Failed to load audio info');
    } catch (e) {
      throw Exception('Error fetching audio info: $e');
    }
  }

  /// 获取音频 URL
  String getAudioUrl(String speaker, String md5) {
    const ossUrl = String.fromEnvironment(
      'OSS_URL',
      defaultValue: 'https://oss.seedict.com', // 替换为实际的 OSS 地址
    );
    return '$ossUrl/audio/$speaker/$md5.mp3';
  }
}
