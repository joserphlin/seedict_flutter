import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/theme.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('入门教程'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '欢迎使用米时典',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.rosyBrown800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '让我们一起学习福州话',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.rosyBrown600,
              ),
            ),
            const SizedBox(height: 32),
            _buildTutorialSection(
              '1. 如何搜索词汇',
              '在主页的搜索框中输入您想查询的词汇，支持福州话汉字、拼音等多种输入方式。'
                  '系统会自动保存您的搜索历史，方便下次快速查询。',
              Icons.search,
            ),
            _buildTutorialSection(
              '2. 浏览词汇卡片',
              '在主页下方，您可以看到随机推荐的词汇卡片。'
                  '左右滑动卡片可以查看更多词汇，点击卡片可以查看详细信息。',
              Icons.style,
            ),
            _buildTutorialSection(
              '3. 查看词汇详情',
              '点击任意词汇可以查看详细信息，包括：\n'
                  '• 标准读音和音频示范\n'
                  '• 详细的释义说明\n'
                  '• 各地方音对比\n'
                  '• 用字规范',
              Icons.info_outline,
            ),
            _buildTutorialSection(
              '4. 学习建议',
              '• 每天学习几个新词汇\n'
                  '• 多听标准读音，模仿发音\n'
                  '• 尝试在日常生活中使用\n'
                  '• 与其他学习者交流',
              Icons.lightbulb_outline,
            ),
            const SizedBox(height: 32),
            Card(
              color: AppTheme.wheat100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.tips_and_updates,
                          color: AppTheme.rosyBrown600,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '小贴士',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.rosyBrown800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '福州话是一门历史悠久的语言，学习需要耐心和坚持。'
                      '建议您从日常用语开始，逐步深入学习。',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.rosyBrown800,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialSection(String title, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.rosyBrown600,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.rosyBrown800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.rosyBrown800,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
