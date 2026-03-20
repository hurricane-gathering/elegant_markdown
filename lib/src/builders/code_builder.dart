import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import '../theme.dart';

/// 代码块渲染器：语法高亮 + 语言标签 + 一键复制
///
/// 注册到 builders['pre'] 以拦截所有围栏代码块。
class CodeBlockBuilder extends MarkdownElementBuilder {
  final ElegantMarkdownTheme theme;

  CodeBlockBuilder({required this.theme});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // pre 元素的第一个子节点是 code 元素
    final codeEl = element.children?.whereType<md.Element>().firstWhere(
          (e) => e.tag == 'code',
          orElse: () => md.Element.empty('code'),
        );

    final code = (codeEl ?? element).textContent.trimRight();
    final classAttr = codeEl?.attributes['class'] ?? '';
    final language = classAttr.startsWith('language-')
        ? classAttr.substring('language-'.length)
        : '';

    return _CodeBlockView(code: code, language: language, theme: theme);
  }
}

// ────────────────────────────────────────────────────────────────────────────

class _CodeBlockView extends StatefulWidget {
  final String code;
  final String language;
  final ElegantMarkdownTheme theme;

  const _CodeBlockView({
    required this.code,
    required this.language,
    required this.theme,
  });

  @override
  State<_CodeBlockView> createState() => _CodeBlockViewState();
}

class _CodeBlockViewState extends State<_CodeBlockView> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: t.codeBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: t.divider.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: t.isDark ? 0.3 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(t),
          _buildBody(t),
        ],
      ),
    );
  }

  Widget _buildHeader(ElegantMarkdownTheme t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: t.isDark
            ? const Color(0xFF1C2128)
            : const Color(0xFFEAECEF),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        border: Border(
          bottom: BorderSide(color: t.divider.withValues(alpha: 0.5), width: 1),
        ),
      ),
      child: Row(
        children: [
          if (widget.language.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: t.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.language,
                style: TextStyle(
                  color: t.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const Spacer(),
          _CopyButton(copied: _copied, onTap: _handleCopy, theme: t),
        ],
      ),
    );
  }

  Widget _buildBody(ElegantMarkdownTheme t) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.vertical(bottom: Radius.circular(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: _buildHighlight(t),
      ),
    );
  }

  Widget _buildHighlight(ElegantMarkdownTheme t) {
    if (widget.language.isNotEmpty) {
      return HighlightView(
        widget.code,
        language: _resolveLanguage(widget.language),
        theme: t.highlightTheme,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          height: 1.65,
        ),
      );
    }
    return Text(
      widget.code,
      style: TextStyle(
        color: t.codeForeground,
        fontFamily: 'monospace',
        fontSize: 14,
        height: 1.65,
      ),
    );
  }

  /// 将常见语言别名统一为 highlight.js 支持的名称
  String _resolveLanguage(String lang) {
    const aliases = {
      'js': 'javascript',
      'ts': 'typescript',
      'py': 'python',
      'rb': 'ruby',
      'sh': 'bash',
      'zsh': 'bash',
      'yml': 'yaml',
      'kt': 'kotlin',
      'rs': 'rust',
    };
    return aliases[lang] ?? lang;
  }

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) return;
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }
}

// ────────────────────────────────────────────────────────────────────────────

class _CopyButton extends StatelessWidget {
  final bool copied;
  final VoidCallback onTap;
  final ElegantMarkdownTheme theme;

  const _CopyButton({
    required this.copied,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Row(
          key: ValueKey(copied),
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              copied ? Icons.check_rounded : Icons.copy_rounded,
              size: 15,
              color: copied
                  ? Colors.green.shade400
                  : theme.onSurface.withValues(alpha: 0.45),
            ),
            const SizedBox(width: 4),
            Text(
              copied ? '已复制' : '复制',
              style: TextStyle(
                fontSize: 12,
                color: copied
                    ? Colors.green.shade400
                    : theme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
