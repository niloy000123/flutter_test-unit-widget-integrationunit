import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/article.dart';
import 'package:flutter_test_app/news_change_notification.dart';
import 'package:flutter_test_app/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut; //system under test
  late MockNewsService mockNewsService;

  setUp(
    () {
      mockNewsService = MockNewsService();
      sut = NewsChangeNotifier(mockNewsService);
    },
  );

  test("initial values are correct", () {
    expect(sut.article, []);
    expect(sut.isLoading, false);
  });

  group("getArticle", () {
    final articlesFromServices = [
      Article(title: "Test 1", content: "Test 1 Content"),
      Article(title: "Test 2", content: "Test 2 Content"),
      Article(title: "Test 3", content: "Test 3 Content"),
    ];
    arrangeNewsServiceReturn3Articles() {
      when(() => mockNewsService.getArticles())
          .thenAnswer((invocation) async => articlesFromServices);
    }

    test("gets article useing the newsService", () async {
      arrangeNewsServiceReturn3Articles();
      await sut.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });

    test("""verify loading of data,
    sets articles to the ones from the service,
    verify the data not loaded anymore """, () async {
      arrangeNewsServiceReturn3Articles();
      final future = sut.getArticles();
      expect(sut.isLoading, true);
      await future;
      expect(sut.article, articlesFromServices);
      expect(sut.isLoading, false);
    });
  });
}
