import 'package:flutter/foundation.dart';
import '../models/word.dart';
import '../services/api_service.dart';

class DeckProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Word> _words = [];
  Set<int> _gone = {};
  bool _isLoading = false;
  String? _error;

  List<Word> get words => _words;
  Set<int> get gone => _gone;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// 获取可见的词汇（未被滑走的）
  List<Word> get visibleWords {
    return _words
        .asMap()
        .entries
        .where((entry) => !_gone.contains(entry.key))
        .map((entry) => entry.value)
        .toList();
  }

  /// 获取词汇卡片
  Future<void> fetchDeck() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _words = await _apiService.fetchDeck();
      _gone.clear();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 标记卡片为已移除
  void markAsGone(int index) {
    if (index >= 0 && index < _words.length) {
      _gone.add(index);
      notifyListeners();

      // 如果所有卡片都被移除，获取新的卡片
      if (_gone.length == _words.length) {
        Future.delayed(const Duration(milliseconds: 500), () {
          fetchDeck();
        });
      }
    }
  }

  /// 重置状态
  void reset() {
    _words = [];
    _gone.clear();
    _error = null;
    notifyListeners();
  }
}
