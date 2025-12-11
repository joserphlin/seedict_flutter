import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/search_history_service.dart';
import '../utils/theme.dart';

class SearchBar extends StatefulWidget {
  final bool autoFocus;

  const SearchBar({super.key, this.autoFocus = false});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final SearchHistoryService _historyService = SearchHistoryService();
  final FocusNode _focusNode = FocusNode();

  List<String> _filteredHistory = [];
  bool _showHistory = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _filterHistory();
    }
  }

  Future<void> _filterHistory() async {
    final history = await _historyService.filterHistory(_controller.text);
    setState(() {
      _filteredHistory = history;
      _showHistory = true;
      _selectedIndex = -1;
    });
  }

  void _handleSubmit() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _showHistory = false;
      _selectedIndex = -1;
    });

    _focusNode.unfocus();
    context.push('/search?q=$query');
  }

  void _selectHistory(String query) {
    _controller.text = query;
    _handleSubmit();
  }

  Future<void> _deleteHistory(String query) async {
    await _historyService.deleteHistory(query);
    _filterHistory();
  }

  Future<void> _clearHistory() async {
    await _historyService.clearHistory();
    setState(() {
      _filteredHistory = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        if (_showHistory) {
          setState(() {
            _showHistory = false;
            _selectedIndex = -1;
          });
          _focusNode.unfocus();
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  _showHistory && _filteredHistory.isNotEmpty ? 24 : 48),
              border: Border.all(
                color: AppTheme.rosyBrown300,
                width: 2,
              ),
              boxShadow: _showHistory && _filteredHistory.isNotEmpty
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                // 搜索输入框
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '搜索福州话词汇...',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            suffixIcon: _controller.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    color: AppTheme.rosyBrown300,
                                    onPressed: () {
                                      _controller.clear();
                                      _filterHistory();
                                    },
                                  )
                                : null,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.rosyBrown800,
                          ),
                          onChanged: (value) => _filterHistory(),
                          onSubmitted: (value) => _handleSubmit(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, size: 28),
                        color: AppTheme.rosyBrown400,
                        onPressed: _handleSubmit,
                      ),
                    ],
                  ),
                ),

                // 历史记录列表
                if (_showHistory && _filteredHistory.isNotEmpty) ...[
                  const Divider(height: 1),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredHistory.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _filteredHistory.length) {
                          // 清空历史按钮
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _clearHistory,
                                child: const Text(
                                  '清空历史',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.rosyBrown300,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        final item = _filteredHistory[index];
                        final isSelected = index == _selectedIndex;

                        return MouseRegion(
                          onEnter: (_) =>
                              setState(() => _selectedIndex = index),
                          onExit: (_) => setState(() => _selectedIndex = -1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.rosyBrown50 : null,
                              border: Border(
                                left: BorderSide(
                                  color: isSelected
                                      ? AppTheme.rosyBrown700
                                      : Colors.transparent,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: ListTile(
                              dense: true,
                              leading: const Icon(
                                Icons.history,
                                color: AppTheme.rosyBrown400,
                                size: 20,
                              ),
                              title: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.rosyBrown700
                                      : AppTheme.rosyBrown600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                color: AppTheme.rosyBrown300,
                                onPressed: () => _deleteHistory(item),
                              ),
                              onTap: () => _selectHistory(item),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
