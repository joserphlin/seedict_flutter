import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/word.dart';
import '../providers/deck_provider.dart';
import '../utils/theme.dart';

class WordsDeck extends StatefulWidget {
  const WordsDeck({super.key});

  @override
  State<WordsDeck> createState() => _WordsDeckState();
}

class _WordsDeckState extends State<WordsDeck>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // 初始加载词汇
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DeckProvider>();
      if (provider.words.isEmpty) {
        provider.fetchDeck();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeckProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.rosyBrown600,
              ),
            ),
          );
        }

        if (provider.error != null) {
          return SizedBox(
            height: 300,
            child: Center(
              child: Text(
                '加载失败: ${provider.error}',
                style: const TextStyle(color: AppTheme.rosyBrown400),
              ),
            ),
          );
        }

        if (provider.words.isEmpty) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: Text(
                '暂无词汇',
                style: TextStyle(color: AppTheme.rosyBrown400),
              ),
            ),
          );
        }

        return SizedBox(
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (int i = provider.words.length - 1; i >= 0; i--)
                if (!provider.gone.contains(i))
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 150 + (i * 4),
                    top: i * 4.0,
                    child: _WordCard(
                      word: provider.words[i],
                      index: i,
                      onDismissed: (direction) {
                        provider.markAsGone(i);
                      },
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}

class _WordCard extends StatefulWidget {
  final Word word;
  final int index;
  final Function(DismissDirection) onDismissed;

  const _WordCard({
    required this.word,
    required this.index,
    required this.onDismissed,
  });

  @override
  State<_WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<_WordCard> {
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/word?w=${widget.word.w}');
      },
      onPanStart: (details) {
        setState(() {
          _isDragging = true;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _position += details.delta;
          _angle = _position.dx / 1000;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isDragging = false;
        });

        // 判断是否滑动足够远
        final velocity = details.velocity.pixelsPerSecond.dx.abs();
        final distance = _position.dx.abs();

        if (velocity > 500 || distance > 100) {
          // 触发移除
          final direction = _position.dx > 0
              ? DismissDirection.endToStart
              : DismissDirection.startToEnd;
          widget.onDismissed(direction);
        } else {
          // 回弹
          setState(() {
            _position = Offset.zero;
            _angle = 0;
          });
        }
      },
      child: AnimatedContainer(
        duration:
            _isDragging ? Duration.zero : const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_angle),
        child: Container(
          width: 300,
          height: 240,
          decoration: BoxDecoration(
            color: AppTheme.rosyBrown50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.wheat200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '#汝会仈儥？',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.wheat400,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.word.text,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.rosyBrown800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.word.pron.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          widget.word.pron,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.rosyBrown600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Text(
                    '释义：${widget.word.expl}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.rosyBrown800,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
