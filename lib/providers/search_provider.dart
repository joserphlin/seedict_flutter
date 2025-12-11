import 'package:flutter/foundation.dart';
import '../models/search_result.dart';
import '../services/api_service.dart';
import '../services/search_history_service.dart';

class SearchProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SearchHistoryService _historyService = SearchHistoryService();

  List<SearchResult> _results = [];
  List<String> _queries = [];
  String? _nextCursor;
  bool _hasMore = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _error;

  List<SearchResult> get results => _results;
  List<String> get queries => _queries;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;

  /// 执行搜索
  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;

    _isLoading = true;
    _error = null;
    _results = [];
    _queries = [];
    _nextCursor = null;
    _hasMore = false;
    notifyListeners();

    try {
      final response = await _apiService.search(query);
      _results = response.results;
      _queries = response.queries;
      _nextCursor = response.nextCursor;
      _hasMore = response.hasMore;

      // 保存搜索历史
      await _historyService.addHistory(query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 加载更多结果
  Future<void> loadMore(String query) async {
    if (!_hasMore || _nextCursor == null || _isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final response = await _apiService.search(query, cursor: _nextCursor);
      _results.addAll(response.results);
      _nextCursor = response.nextCursor;
      _hasMore = response.hasMore;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// 清空搜索结果
  void clear() {
    _results = [];
    _queries = [];
    _nextCursor = null;
    _hasMore = false;
    _error = null;
    notifyListeners();
  }
}
