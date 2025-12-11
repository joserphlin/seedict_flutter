import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于'),
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
            Center(
              child: Column(
                children: [
                  const Text(
                    '米时典',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.rosyBrown800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SeeDict',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppTheme.rosyBrown600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '福州话词典',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.rosyBrown600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '项目简介',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.rosyBrown800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '米时典（SeeDict）是一个致力于保护和传承福州话（闽东语）的在线词典项目。'
                      '我们希望通过现代化的技术手段，让更多人了解和学习福州话，'
                      '为福州话的传承贡献一份力量。',
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
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '功能特点',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.rosyBrown800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem('📚', '丰富的词汇库'),
                    _buildFeatureItem('🔍', '智能搜索功能'),
                    _buildFeatureItem('🎵', '标准读音示范'),
                    _buildFeatureItem('📖', '详细的释义说明'),
                    _buildFeatureItem('🌏', '各地方音对比'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '版本信息',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.rosyBrown800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '版本: 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.rosyBrown600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '© 2024 SeeDict. All rights reserved.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosyBrown400,
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

  Widget _buildFeatureItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.rosyBrown800,
            ),
          ),
        ],
      ),
    );
  }
}
