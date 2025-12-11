import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/api_config.dart';
import '../utils/theme.dart';

/// API 配置调试面板
/// 显示当前的 API 配置信息，帮助调试连接问题
class ApiDebugPanel extends StatelessWidget {
  const ApiDebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.bug_report,
                  color: AppTheme.rosyBrown600,
                ),
                const SizedBox(width: 8),
                const Text(
                  'API 配置信息',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.rosyBrown800,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('平台', ApiConfig.getPlatformInfo()),
            _buildInfoRow('环境', ApiConfig.isDevelopment() ? '开发环境' : '生产环境'),
            _buildInfoRow('API 地址', ApiService.baseUrl),
            // _buildInfoRow('OSS 地址', ApiService.ossUrl),
            const SizedBox(height: 16),
            _buildTestButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.rosyBrown700,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(
                color: AppTheme.rosyBrown800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _testConnection(context),
        icon: const Icon(Icons.network_check),
        label: const Text('测试 API 连接'),
      ),
    );
  }

  Future<void> _testConnection(BuildContext context) async {
    // 显示加载对话框
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('正在测试连接...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final apiService = ApiService();
      await apiService.fetchDeck();

      if (context.mounted) {
        Navigator.pop(context); // 关闭加载对话框
        _showResultDialog(
          context,
          '连接成功',
          '✅ API 连接正常，可以正常使用！',
          true,
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // 关闭加载对话框
        _showResultDialog(
          context,
          '连接失败',
          '❌ 错误信息：\n\n$e\n\n请检查：\n'
              '1. API 服务器是否启动\n'
              '2. API 地址是否正确\n'
              '3. 网络连接是否正常',
          false,
        );
      }
    }
  }

  void _showResultDialog(
    BuildContext context,
    String title,
    String message,
    bool isSuccess,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
