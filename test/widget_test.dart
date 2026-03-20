import 'package:elegant_markdown/elegant_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ElegantMarkdown', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ElegantMarkdown(data: '# Hello'),
            ),
          ),
        ),
      );
      expect(find.byType(ElegantMarkdown), findsOneWidget);
    });

    testWidgets('renders with light theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ElegantMarkdown(
                data: '**bold** and `code`',
                theme: ElegantMarkdownTheme.light(),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(ElegantMarkdown), findsOneWidget);
    });

    testWidgets('renders with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ElegantMarkdown(
                data: '# Dark\n\n> Blockquote',
                theme: ElegantMarkdownTheme.dark(),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(ElegantMarkdown), findsOneWidget);
    });
  });

  group('ElegantMarkdownTheme', () {
    test('light theme has correct brightness', () {
      final theme = ElegantMarkdownTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.isDark, isFalse);
    });

    test('dark theme has correct brightness', () {
      final theme = ElegantMarkdownTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.isDark, isTrue);
    });
  });
}
