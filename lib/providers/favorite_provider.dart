import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/word.dart';

class FavoriteProvider extends ChangeNotifier {
  static const String _key = 'favorites';
  Map<String, Word> _favorites = {};
  bool _isLoading = true;

  List<Word> get favorites => _favorites.values.toList();
  bool get isLoading => _isLoading;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_key);

      if (favoritesJson != null) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        final Map<String, Word> loaded = {};
        for (var item in decoded) {
          final word = Word.fromJson(item);
          loaded[word.w] = word;
        }
        _favorites = loaded;
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String w) {
    return _favorites.containsKey(w);
  }

  Future<void> toggleFavorite(Word word) async {
    if (_favorites.containsKey(word.w)) {
      _favorites.remove(word.w);
    } else {
      _favorites[word.w] = word;
    }
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonList =
          _favorites.values.map((w) => w.toJson()).toList();
      await prefs.setString(_key, json.encode(jsonList));
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }
}
