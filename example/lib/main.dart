import 'package:elegant_markdown/elegant_markdown.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

const String _kDemo = r'''
# ElegantMarkdown Demo

> A Flutter component for rendering **Markdown + LaTeX** with elegant styling.

---

## Text Styles

Normal paragraph with comfortable line height.

**Bold** · *Italic* · ~~Strikethrough~~ · `inline code` · Emoji 🚀 🎉

---

## Code Block

```dart
ElegantMarkdown(
  data: markdownText,
  theme: ElegantMarkdownTheme.light(),
  onTapLink: (url) => print('Tapped: $url'),
)
```

## Math Formulas

Inline: $E = mc^2$ and $\int_0^\infty e^{-x}\,dx = 1$

Block display:

$$
\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}
$$

## Task List

- [x] Markdown rendering
- [x] LaTeX math support
- [x] Syntax highlighting
- [ ] More themes

## Table

| Feature | Supported |
|---------|-----------|
| GFM     | ✅        |
| LaTeX   | ✅        |
| Themes  | ✅        |

## Blockquote

> "The best way to predict the future is to invent it."
> — Alan Kay
''';

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final theme =
        _isDark ? ElegantMarkdownTheme.dark() : ElegantMarkdownTheme.light();

    return MaterialApp(
      title: 'ElegantMarkdown Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          title: const Text('ElegantMarkdown'),
          backgroundColor: theme.background,
          actions: [
            IconButton(
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => _isDark = !_isDark),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ElegantMarkdown(
              data: _kDemo,
              theme: theme,
              selectable: true,
            ),
          ),
        ),
      ),
    );
  }
}
