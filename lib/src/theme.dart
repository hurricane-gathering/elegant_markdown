import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

/// Configuration object that controls the visual appearance of [ElegantMarkdown].
///
/// Two built-in presets are provided:
///
/// ```dart
/// ElegantMarkdownTheme.light()  // GitHub-inspired light theme
/// ElegantMarkdownTheme.dark()   // GitHub-inspired dark theme
/// ```
///
/// Or supply a fully custom theme:
///
/// ```dart
/// ElegantMarkdownTheme(
///   brightness: Brightness.light,
///   background: Colors.white,
///   primary: Colors.blue,
///   highlightTheme: githubTheme,
///   // ...
/// )
/// ```
class ElegantMarkdownTheme {
  /// Whether this is a [Brightness.light] or [Brightness.dark] theme.
  final Brightness brightness;

  /// Page / scaffold background color.
  final Color background;

  /// Surface color used for subtle containers (code background, table header, etc.).
  final Color surface;

  /// Primary foreground color for body text and headings.
  final Color onSurface;

  /// Accent color used for links, checked checkboxes, and interactive elements.
  final Color primary;

  /// Background color of fenced code blocks.
  final Color codeBackground;

  /// Default foreground color inside code blocks (used when no highlight theme applies).
  final Color codeForeground;

  /// Color of inline `` `code` `` spans.
  final Color inlineCodeColor;

  /// Left-border color of blockquote elements.
  final Color blockquoteBorder;

  /// Background fill of blockquote elements.
  final Color blockquoteBackground;

  /// Border color of table cells.
  final Color tableBorder;

  /// Background color of the `<thead>` row.
  final Color tableHeaderBackground;

  /// Background color of alternating table rows.
  final Color tableAltRowBackground;

  /// Color used for horizontal rules (`---`) and other subtle dividers.
  final Color divider;

  /// Syntax-highlighting theme map passed directly to `flutter_highlight`.
  ///
  /// Use any theme from `package:flutter_highlight/themes/*.dart`, e.g.
  /// `githubTheme`, `vs2015Theme`, `monokaiTheme`.
  final Map<String, TextStyle> highlightTheme;

  /// Creates a custom [ElegantMarkdownTheme].
  ///
  /// All parameters are required. Prefer the factory constructors
  /// [ElegantMarkdownTheme.light] and [ElegantMarkdownTheme.dark]
  /// for common use cases.
  const ElegantMarkdownTheme({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.primary,
    required this.codeBackground,
    required this.codeForeground,
    required this.inlineCodeColor,
    required this.blockquoteBorder,
    required this.blockquoteBackground,
    required this.tableBorder,
    required this.tableHeaderBackground,
    required this.tableAltRowBackground,
    required this.divider,
    required this.highlightTheme,
  });

  /// GitHub-inspired light theme.
  factory ElegantMarkdownTheme.light() => ElegantMarkdownTheme(
        brightness: Brightness.light,
        background: const Color(0xFFFFFFFF),
        surface: const Color(0xFFF6F8FA),
        onSurface: const Color(0xFF1F2328),
        primary: const Color(0xFF0969DA),
        codeBackground: const Color(0xFFF6F8FA),
        codeForeground: const Color(0xFF1F2328),
        inlineCodeColor: const Color(0xFFD63384),
        blockquoteBorder: const Color(0xFFD0D7DE),
        blockquoteBackground: const Color(0xFFF6F8FA),
        tableBorder: const Color(0xFFD0D7DE),
        tableHeaderBackground: const Color(0xFFF6F8FA),
        tableAltRowBackground: const Color(0xFFFAFAFA),
        divider: const Color(0xFFD0D7DE),
        highlightTheme: githubTheme,
      );

  /// GitHub-inspired dark theme.
  factory ElegantMarkdownTheme.dark() => ElegantMarkdownTheme(
        brightness: Brightness.dark,
        background: const Color(0xFF0D1117),
        surface: const Color(0xFF161B22),
        onSurface: const Color(0xFFE6EDF3),
        primary: const Color(0xFF58A6FF),
        codeBackground: const Color(0xFF161B22),
        codeForeground: const Color(0xFFE6EDF3),
        inlineCodeColor: const Color(0xFFFF79C6),
        blockquoteBorder: const Color(0xFF3D444D),
        blockquoteBackground: const Color(0xFF161B22),
        tableBorder: const Color(0xFF3D444D),
        tableHeaderBackground: const Color(0xFF1C2128),
        tableAltRowBackground: const Color(0xFF161B22),
        divider: const Color(0xFF3D444D),
        highlightTheme: vs2015Theme,
      );

  /// `true` when [brightness] is [Brightness.dark].
  bool get isDark => brightness == Brightness.dark;
}
