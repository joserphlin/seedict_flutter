import 'dart:io';

/// API 配置工具类
/// 自动处理不同平台的 localhost 问题
class ApiConfig {
  /// 获取基础 API URL
  static String getBaseUrl() {
    // 优先使用环境变量
    const envUrl = String.fromEnvironment('API_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }

    // 根据平台返回合适的 localhost 地址
    return _getDefaultUrl();
  }

  /// 获取默认 URL（根据平台）
  static String _getDefaultUrl() {
    const localPort = '8000';
    const apiPath = '/api/v1';

    try {
      if (Platform.isAndroid) {
        // Android 模拟器使用特殊 IP
        return 'http://10.0.2.2:$localPort$apiPath';
      } else if (Platform.isIOS) {
        // iOS 模拟器需要使用宿主机 IP
        // 注意：真机测试时也需要使用局域网 IP
        // 这里使用 localhost，如果不工作，请使用 --dart-define 指定 IP
        return 'http://localhost:$localPort$apiPath';
      } else {
        // Web 和其他平台使用 localhost
        return 'http://localhost:$localPort$apiPath';
      }
    } catch (e) {
      // 如果 Platform 不可用（Web），使用 localhost
      return 'http://localhost:$localPort$apiPath';
    }
  }

  /// 获取 OSS URL
  static String getOssUrl() {
    const envUrl = String.fromEnvironment('OSS_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }
    return 'https://oss.seedict.com';
  }

  /// 检查是否为开发环境
  static bool isDevelopment() {
    return getBaseUrl().contains('localhost') ||
        getBaseUrl().contains('10.0.2.2') ||
        getBaseUrl().contains('127.0.0.1');
  }

  /// 获取当前平台信息（用于调试）
  static String getPlatformInfo() {
    try {
      if (Platform.isAndroid) return 'Android';
      if (Platform.isIOS) return 'iOS';
      if (Platform.isMacOS) return 'macOS';
      if (Platform.isWindows) return 'Windows';
      if (Platform.isLinux) return 'Linux';
      return 'Unknown';
    } catch (e) {
      return 'Web';
    }
  }
}
