import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/favorite_provider.dart';
import '../utils/theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏夹'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.rosyBrown600,
              ),
            );
          }

          if (provider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_border,
                    size: 64,
                    color: AppTheme.rosyBrown200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '暂无收藏',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.rosyBrown400,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final word = provider.favorites[index];
              return Card(
                child: ListTile(
                  title: Text(
                    word.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.rosyBrown800,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (word.pron.isNotEmpty)
                        Text(
                          word.pron,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.rosyBrown600,
                          ),
                        ),
                      if (word.expl.isNotEmpty)
                        Text(
                          word.expl,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.rosyBrown800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: AppTheme.rosyBrown300,
                    onPressed: () {
                      provider.toggleFavorite(word);
                    },
                  ),
                  onTap: () {
                    context.push('/word?w=${word.w}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
