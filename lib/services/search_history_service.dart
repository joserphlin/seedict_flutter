import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchHistoryService {
  static const String _key = 'search_history';
  static const int _maxHistorySize = 50;

  /// 保存搜索历史
  Future<void> addHistory(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getHistory();

    // 移除重复项
    history.remove(query);

    // 添加到开头
    history.insert(0, query);

    // 限制历史记录数量
    if (history.length > _maxHistorySize) {
      history = history.sublist(0, _maxHistorySize);
    }

    await prefs.setString(_key, json.encode(history));
  }

  /// 获取搜索历史
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString(_key);

    if (historyJson == null) return [];

    try {
      final List<dynamic> decoded = json.decode(historyJson);
      return decoded.map((item) => item.toString()).toList();
    } catch (e) {
      return [];
    }
  }

  /// 根据查询过滤历史
  Future<List<String>> filterHistory(String query) async {
    final history = await getHistory();

    if (query.isEmpty) return history.take(10).toList();

    return history
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .take(10)
        .toList();
  }

  /// 删除单条历史
  Future<void> deleteHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getHistory();

    history.remove(query);
    await prefs.setString(_key, json.encode(history));
  }

  /// 清空所有历史
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
