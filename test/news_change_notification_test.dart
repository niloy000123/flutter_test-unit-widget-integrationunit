import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/news_change_notification.dart';
import 'package:flutter_test_app/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;

  setUp(
    () {
      mockNewsService = MockNewsService();
      sut = NewsChangeNotifier(mockNewsService);
    },
  );

  test("initial vallues are correct", () {
    expect(sut.article, []);
    expect(sut.isLoading, false);
  });

  group("getArticle", () {
    test("ge", () {
      sut.getArticles();
      mockNewsService.getArticles();
    });
  });
}
