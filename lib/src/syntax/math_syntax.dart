import 'package:markdown/markdown.dart';

/// 行内数学公式语法：$...$（单行）和 $$...$$（显示模式，单行内）
///
/// 匹配优先级：先尝试 $$...$$，再尝试 $...$
class InlineMathSyntax extends InlineSyntax {
  // $$...$$（display）| $...$（text，不允许跨行、不允许空白包围）
  InlineMathSyntax()
      : super(
          r'\$\$(.+?)\$\$|\$([^$\s][^$\n]*?[^$\s]|[^$\s])\$',
          caseSensitive: true,
        );

  @override
  bool onMatch(InlineParser parser, Match match) {
    final isDisplay = match[1] != null;
    final latex = (match[1] ?? match[2])!.trim();
    final tag = isDisplay ? 'displaymath' : 'inlinemath';
    parser.addNode(Element.text(tag, latex));
    return true;
  }
}

/// 块级数学公式语法：独占一行的 $$...$$（多行内容）
///
/// 示例：
/// $$
/// \int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
/// $$
class BlockMathSyntax extends BlockSyntax {
  static final _startPattern = RegExp(r'^\$\$\s*$');

  @override
  RegExp get pattern => _startPattern;

  @override
  bool canEndBlock(BlockParser parser) => false;

  @override
  Node parse(BlockParser parser) {
    parser.advance(); // 跳过开头 $$
    final buffer = StringBuffer();
    while (!parser.isDone) {
      if (parser.current.content.trim() == r'$$') {
        parser.advance(); // 跳过结尾 $$
        break;
      }
      buffer.writeln(parser.current.content);
      parser.advance();
    }
    return Element('blockmath', [Text(buffer.toString().trim())]);
  }
}
