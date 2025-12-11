import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NavPanel extends StatelessWidget {
  const NavPanel({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavButton(
            label: '主页',
            onTap: () => context.go('/'),
          ),
          _NavButton(
            label: '入门',
            onTap: () => context.push('/tutorial'),
          ),
          _NavButton(
            label: '帮助',
            onTap: () => _launchUrl(
                'https://jcnf40n3hvft.feishu.cn/docx/FSqidtsgjo25x0x6R1KcChopnTc'),
          ),
          _NavButton(
            label: '关于',
            onTap: () => context.push('/about'),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.wheat50 : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _isHovered ? AppTheme.rosyBrown800 : AppTheme.rosyBrown600,
            ),
          ),
        ),
      ),
    );
  }
}
