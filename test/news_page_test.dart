import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/article.dart';
import 'package:flutter_test_app/news_change_notification.dart';
import 'package:flutter_test_app/news_page.dart';
import 'package:flutter_test_app/news_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;
  setUp(
    () {
      mockNewsService = MockNewsService();
    },
  );

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: NewsPage(),
      ),
    );
  }

  final articlesFromServices = [
    Article(title: "Test 1", content: "Test 1 Content"),
    Article(title: "Test 2", content: "Test 2 Content"),
    Article(title: "Test 3", content: "Test 3 Content"),
  ];
  arrangeNewsServiceReturn3Articles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((invocation) async => articlesFromServices);
  }

  arrangeNewsServiceReturn3ArticlesAfter2SecWait() {
    when(() => mockNewsService.getArticles()).thenAnswer((invocation) async {
      await Future.delayed(const Duration(seconds: 2));
      return articlesFromServices;
    });
  }

  testWidgets("Title is display", (WidgetTester tester) async {
    arrangeNewsServiceReturn3Articles();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text("news"), findsOneWidget);
  });

  testWidgets("Loading indicator is display while weating for articles",
      (WidgetTester tester) async {
    arrangeNewsServiceReturn3ArticlesAfter2SecWait();
    final future = tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await future;
  });
}
