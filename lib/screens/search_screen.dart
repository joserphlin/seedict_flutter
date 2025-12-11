import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/search_provider.dart';
import '../utils/theme.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchProvider>().search(widget.query);
    });
  }

  @override
  void didUpdateWidget(SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      context.read<SearchProvider>().search(widget.query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索结果'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.rosyBrown600,
              ),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.rosyBrown400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '搜索失败',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    style: const TextStyle(color: AppTheme.rosyBrown400),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Query display
                if (provider.queries.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.wheat300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '查询：${provider.queries.join('、')}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Results
                if (provider.results.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        '未找到相关结果',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.rosyBrown400,
                        ),
                      ),
                    ),
                  )
                else
                  ...provider.results.map((result) {
                    return GestureDetector(
                      onTap: () => context.push('/word?w=${result.w}'),
                      child: Container(
                        width: double.infinity, // 统一宽度为全宽
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme
                              .wheat200, // 加深背景颜色（从 wheat100 改为 wheat200）
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Source tags
                            if (result.refs != null && result.refs!.isNotEmpty)
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: result.refs!.map((ref) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.wheat500.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.book,
                                          size: 14,
                                          color: AppTheme.wheat500,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          ref,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.wheat500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            const SizedBox(height: 8),

                            // Word text
                            Text(
                              result.text,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.rosyBrown800,
                              ),
                            ),
                            if (result.pron.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                result.pron,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.rosyBrown600,
                                ),
                              ),
                            ],

                            // Brief explanation
                            if (result.brief != null &&
                                result.brief!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                result.brief!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.wheat600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                // Load more button
                if (provider.hasMore)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: provider.isLoadingMore
                            ? null
                            : () => provider.loadMore(widget.query),
                        child: provider.isLoadingMore
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('加载更多'),
                      ),
                    ),
                  ),

                // Footer message
                if (!provider.hasMore && provider.results.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        '已显示所有 ${provider.results.length} 条相关结果',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.wheat500,
                        ),
                      ),
                    ),
                  ),

                // Feedback links
                const SizedBox(height: 16),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: '没有找到想找的词汇？尝试',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.wheat400,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // Open feedback form
                            },
                            child: const Text(
                              '向我们反馈',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.wheat600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: '或'),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // Open submission form
                            },
                            child: const Text(
                              '向我们提交数据',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.wheat600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
