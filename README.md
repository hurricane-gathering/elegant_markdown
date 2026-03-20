# elegant_markdown

[![pub package](https://img.shields.io/pub/v/elegant_markdown.svg)](https://pub.dev/packages/elegant_markdown)
[![pub points](https://img.shields.io/pub/points/elegant_markdown)](https://pub.dev/packages/elegant_markdown/score)
[![likes](https://img.shields.io/pub/likes/elegant_markdown)](https://pub.dev/packages/elegant_markdown/score)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A high-quality Flutter component for rendering **Markdown + LaTeX** simultaneously.  
Styled after Notion / GitHub — clean, readable, and fully customizable.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 📝 **Full Markdown** | GFM — headings, bold/italic/strikethrough, lists, blockquotes, HR |
| 💻 **Code Highlighting** | Syntax highlighting via `flutter_highlight` with copy button |
| 🔢 **LaTeX Math** | Inline `$...$`, display `$$...$$`, multi-line `$$` blocks via `flutter_math_fork` |
| ☑️ **Task Lists** | `- [x]` / `- [ ]` rendered as checkboxes |
| 📊 **Tables** | GFM tables with border + padding |
| 🖼️ **Images** | Network images with loading/error placeholders |
| 🔗 **Links** | Opens with `url_launcher`, custom handler supported |
| 🌗 **Themes** | Built-in Light & Dark, follows system brightness automatically |
| ✂️ **Selectable** | Optional text selection |

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  elegant_markdown: ^0.1.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

```dart
import 'package:elegant_markdown/elegant_markdown.dart';

// Minimal usage — auto-follows system theme
ElegantMarkdown(
  data: '# Hello\n\nThis is **bold** and $E=mc^2$.',
)

// Full API
ElegantMarkdown(
  data: markdownText,
  theme: ElegantMarkdownTheme.light(),   // or .dark()
  onTapLink: (url) => launchUrl(Uri.parse(url)),
  selectable: true,
  maxWidth: 800,
  padding: const EdgeInsets.all(16),
)
```

---

## 🧩 API Reference

### `ElegantMarkdown`

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `data` | `String` | required | Markdown source text |
| `theme` | `ElegantMarkdownTheme?` | auto | Theme config; auto-detects system brightness if null |
| `onTapLink` | `ValueChanged<String>?` | opens URL | Called when a link is tapped |
| `selectable` | `bool` | `false` | Enable text selection |
| `padding` | `EdgeInsetsGeometry` | zero | Outer padding |
| `maxWidth` | `double?` | null | Content max width (auto-centered) |

---

### `ElegantMarkdownTheme`

```dart
// Built-in presets
ElegantMarkdownTheme.light()   // GitHub-inspired light theme
ElegantMarkdownTheme.dark()    // GitHub-inspired dark theme

// Custom theme
ElegantMarkdownTheme(
  brightness: Brightness.light,
  background: Colors.white,
  surface: Color(0xFFF6F8FA),
  onSurface: Color(0xFF1F2328),
  primary: Color(0xFF0969DA),            // links, checkboxes
  codeBackground: Color(0xFFF6F8FA),
  codeForeground: Color(0xFF1F2328),
  inlineCodeColor: Color(0xFFD63384),    // inline `code` color
  blockquoteBorder: Color(0xFFD0D7DE),
  blockquoteBackground: Color(0xFFF6F8FA),
  tableBorder: Color(0xFFD0D7DE),
  tableHeaderBackground: Color(0xFFF6F8FA),
  tableAltRowBackground: Color(0xFFFAFAFA),
  divider: Color(0xFFD0D7DE),
  highlightTheme: githubTheme,           // from flutter_highlight
)
```

---

## 📐 Markdown Syntax Reference

### Text

```markdown
# H1  ## H2  ### H3

**bold**  *italic*  ~~strikethrough~~  `inline code`
```

### Math (LaTeX)

```markdown
Inline: $E = mc^2$

Display (single line): $$\frac{a}{b}$$

Block (multi-line):
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$
```

### Code Blocks

````markdown
```dart
void main() => runApp(const MyApp());
```
````

Supported language tags: `dart`, `python`, `javascript`, `typescript`,
`java`, `kotlin`, `swift`, `rust`, `go`, `bash`, `yaml`, `json`, `sql`, `html`, `css`, and more.

### Task Lists

```markdown
- [x] Completed task
- [ ] Pending task
```

### Tables

```markdown
| Column A | Column B |
|----------|----------|
| Cell 1   | Cell 2   |
```

---

## 🌗 Theme Usage

### Explicit Theme

```dart
ElegantMarkdown(
  data: content,
  theme: ElegantMarkdownTheme.dark(),
)
```

### Auto Follow System Theme

Simply omit `theme` — the widget reads `Theme.of(context).brightness`:

```dart
ElegantMarkdown(data: content)
```

### Dynamic Toggle

```dart
class _MyState extends State<MyPage> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return ElegantMarkdown(
      data: content,
      theme: _isDark
          ? ElegantMarkdownTheme.dark()
          : ElegantMarkdownTheme.light(),
    );
  }
}
```

---

## 🔧 Scrollable Document

`ElegantMarkdown` renders as a non-scrolling body (`MarkdownBody` under the hood).  
Wrap it in a `SingleChildScrollView` for scrollable documents:

```dart
SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: ElegantMarkdown(data: longDocument),
)
```

---

## 🏗️ Architecture

```
elegant_markdown/
├── lib/
│   ├── elegant_markdown.dart        # Public API entry point
│   └── src/
│       ├── theme.dart               # ElegantMarkdownTheme
│       ├── syntax/
│       │   └── math_syntax.dart     # InlineMathSyntax + BlockMathSyntax
│       └── builders/
│           ├── code_builder.dart    # Code block with highlight + copy
│           └── math_builder.dart    # LaTeX inline + block builders
└── example/
    └── lib/main.dart                # Runnable demo app
```

**Key design decisions:**

- `BlockMathBuilder.isBlockElement() = true` — registers `blockmath` into flutter_markdown's block tag list, preventing inline-context errors.
- Custom `InlineMathSyntax` regex matches both `$...$` and `$$...$$` (single-line display) as inline nodes.
- Custom `BlockMathSyntax` handles multi-line `$$...$$` blocks as top-level block elements.
- `builders['pre']` intercepts all fenced code blocks; language is read from `class="language-*"` attribute.

---

## 🤝 Contributing

Contributions, issues, and pull requests are welcome!  
See [CONTRIBUTING.md](CONTRIBUTING.md) or open an [issue](https://github.com/fluttercommunity/elegant_markdown/issues).

1. Fork the repository
2. Create your feature branch: `git checkout -b feat/awesome-feature`
3. Commit changes: `git commit -m 'feat: add awesome feature'`
4. Push: `git push origin feat/awesome-feature`
5. Open a Pull Request

---

## 📄 License

MIT © 2026 — See [LICENSE](LICENSE) for details.
