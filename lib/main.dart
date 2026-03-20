import 'package:flutter/material.dart';

import 'elegant_markdown.dart';
import 'src/demo_content.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElegantMarkdown Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const DemoPage(),
    );
  }
}

// ─── Demo 页面 ────────────────────────────────────────────────────────────────

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _isDark = false;

  ElegantMarkdownTheme get _theme =>
      _isDark ? ElegantMarkdownTheme.dark() : ElegantMarkdownTheme.light();

  @override
  Widget build(BuildContext context) {
    final t = _theme;

    return AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: _isDark
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      child: Scaffold(
        backgroundColor: t.background,
        appBar: _buildAppBar(t),
        body: _buildBody(t),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ElegantMarkdownTheme t) {
    return AppBar(
      backgroundColor: t.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: t.divider),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: t.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.article_outlined, color: t.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Text(
            'ElegantMarkdown',
            style: TextStyle(
              color: t.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        // 主题切换
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _ThemeToggle(
            isDark: _isDark,
            theme: t,
            onToggle: () => setState(() => _isDark = !_isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ElegantMarkdownTheme t) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElegantMarkdown(
              data: kDemoMarkdown,
              theme: t,
              selectable: true,
              onTapLink: (url) {
                debugPrint('Link tapped: $url');
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─── 主题切换按钮 ─────────────────────────────────────────────────────────────

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final ElegantMarkdownTheme theme;
  final VoidCallback onToggle;

  const _ThemeToggle({
    required this.isDark,
    required this.theme,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 72,
        height: 36,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C2128) : const Color(0xFFEAECEF),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.divider, width: 1.5),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 图标行
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.light_mode_rounded,
                      size: 15,
                      color: isDark
                          ? theme.onSurface.withValues(alpha: 0.3)
                          : Colors.amber.shade700),
                  Icon(Icons.dark_mode_rounded,
                      size: 15,
                      color: isDark
                          ? Colors.indigo.shade300
                          : theme.onSurface.withValues(alpha: 0.3)),
                ],
              ),
            ),
            // 滑块
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isDark
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF3D444D)
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
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
}
