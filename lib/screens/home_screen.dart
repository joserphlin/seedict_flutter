import 'package:flutter/material.dart';
import '../widgets/nav_panel.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/words_deck.dart';
import '../utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollY = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollY = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoOpacity = (_scrollY / 500).clamp(0.0, 1.0);
    final logoTranslateY = (_scrollY * 1).clamp(0.0, 200.0);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Header section with nav and logo
              Container(
                color: AppTheme.wheat50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    // Navigation panel
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: const NavPanel(),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Logo with scroll animation
                    Opacity(
                      opacity: 1 - logoOpacity,
                      child: Transform.translate(
                        offset: Offset(0, -logoTranslateY),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Image.asset(
                            'assets/logo-see.png',
                            height: 120,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                '米时典',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.rosyBrown800,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Search bar
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: const custom.SearchBar(),
                    ),
                  ],
                ),
              ),

              // Words deck section
              Container(
                color: AppTheme.wheat50,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: const WordsDeck(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
