import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<PackageInfo> _packageInfoFuture;

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = PackageInfo.fromPlatform();
  }

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
                  Image.asset(
                    'assets/memo-bangua.webp',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.book,
                        size: 80,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '米时典',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.displaySmall?.color,
                    ),
                  ),
                  Text(
                    'SeeDict',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '福州话词典',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                    Text(
                      '项目简介',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '米时典（SeeDict）是一个致力于保护和传承福州话（闽东语）的在线词典项目。'
                      '我们希望通过现代化的技术手段，让更多人了解和学习福州话，'
                      '为福州话的传承贡献一份力量。',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
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
                    Text(
                      '功能特点',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(context, '📚', '丰富的词汇库'),
                    _buildFeatureItem(context, '🔍', '智能搜索功能'),
                    _buildFeatureItem(context, '🎵', '标准读音示范'),
                    _buildFeatureItem(context, '📖', '详细的释义说明'),
                    _buildFeatureItem(context, '🌏', '各地方音对比'),
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
                    Text(
                      '外观设置',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Column(
                          children: [
                            RadioListTile<ThemeMode>(
                              title: Text(
                                '跟随系统',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              value: ThemeMode.system,
                              groupValue: themeProvider.themeMode,
                              onChanged: (value) =>
                                  themeProvider.setThemeMode(value!),
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            RadioListTile<ThemeMode>(
                              title: Text(
                                '浅色模式',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              value: ThemeMode.light,
                              groupValue: themeProvider.themeMode,
                              onChanged: (value) =>
                                  themeProvider.setThemeMode(value!),
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            RadioListTile<ThemeMode>(
                              title: Text(
                                '深色模式',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              value: ThemeMode.dark,
                              groupValue: themeProvider.themeMode,
                              onChanged: (value) =>
                                  themeProvider.setThemeMode(value!),
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        );
                      },
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
                    Text(
                      '版本信息',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FutureBuilder<PackageInfo>(
                      future: _packageInfoFuture,
                      builder: (context, snapshot) {
                        String versionText = '正在获取...';
                        if (snapshot.hasData) {
                          versionText = '版本: ${snapshot.data!.version}';
                        } else if (snapshot.hasError) {
                          versionText = '';
                        }

                        return Text(
                          versionText,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2024 SeeDict. All rights reserved.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildFeatureItem(BuildContext context, String emoji, String text) {
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
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
