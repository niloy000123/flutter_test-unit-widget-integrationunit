import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_test_app/article.dart';

class NewsService {
  final _articles = List.generate(
      10,
      (index) => Article(
          title: lorem(paragraphs: 1, words: 3),
          content: lorem(paragraphs: 10, words: 500)));

  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }

  Future<Article> getArticless() async {
    await Future.delayed(const Duration(seconds: 1));
    return Article(
        title: lorem(paragraphs: 1, words: 3),
        content: lorem(paragraphs: 10, words: 500));
  }
}
