import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;

import '../theme.dart';

// ─── 行内公式渲染器 ────────────────────────────────────────────────────────────

/// 处理 `inlinemath`（$...$）和 `displaymath`（$$...$$，单行）
class InlineMathBuilder extends MarkdownElementBuilder {
  final ElegantMarkdownTheme theme;

  InlineMathBuilder({required this.theme});

  @override
  bool isBlockElement() => false;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final latex = element.textContent.trim();
    final isDisplay = element.tag == 'displaymath';

    final textStyle = (preferredStyle ?? const TextStyle()).copyWith(
      color: theme.onSurface,
      fontSize: preferredStyle?.fontSize ?? 16,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Math.tex(
        latex,
        mathStyle: isDisplay ? MathStyle.display : MathStyle.text,
        textStyle: textStyle,
        onErrorFallback: (err) => _LatexErrorView(latex: latex),
      ),
    );
  }
}

// ─── 块级公式渲染器 ────────────────────────────────────────────────────────────

/// 处理 `blockmath`（多行 $$...$$），显示为居中公式块
class BlockMathBuilder extends MarkdownElementBuilder {
  final ElegantMarkdownTheme theme;

  BlockMathBuilder({required this.theme});

  @override
  bool isBlockElement() => true;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final latex = element.textContent.trim();

    final textStyle = (preferredStyle ?? const TextStyle()).copyWith(
      color: theme.onSurface,
      fontSize: preferredStyle?.fontSize ?? 17,
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: theme.codeBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.divider.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Math.tex(
          latex,
          mathStyle: MathStyle.display,
          textStyle: textStyle,
          onErrorFallback: (err) => _LatexErrorView(latex: latex),
        ),
      ),
    );
  }
}

// ─── LaTeX 解析失败降级展示 ───────────────────────────────────────────────────

class _LatexErrorView extends StatelessWidget {
  final String latex;

  const _LatexErrorView({required this.latex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Text(
        latex,
        style: const TextStyle(
          color: Colors.red,
          fontFamily: 'monospace',
          fontSize: 13,
        ),
      ),
    );
  }
}
