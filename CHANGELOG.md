# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] - 2026-03-20

### Added

- **Core component** `ElegantMarkdown` widget with full GFM support
- **LaTeX math rendering** via `flutter_math_fork`
  - Inline math: `$...$`
  - Single-line display math: `$$...$$`
  - Multi-line block math: fenced `$$` blocks
- **Code syntax highlighting** via `flutter_highlight` with 20+ language themes
  - Language label badge in code block header
  - One-click copy button with animated feedback
  - Horizontal scroll for long code lines
- **`ElegantMarkdownTheme`** with built-in Light and Dark presets
  - Auto-follows system `Brightness` when `theme` is omitted
  - Fully customizable colors and highlight themes
- **Task list** checkboxes (`- [x]` / `- [ ]`)
- **Tables** with GFM border support
- **Blockquotes** with left border and subtle background
- **Images** with loading indicator and error placeholder
- **Link handling** via `url_launcher` with optional custom callback
- **Selectable text** via `selectable` parameter
- **`maxWidth`** constraint for centered reading layouts
