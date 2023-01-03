import 'package:flutter/material.dart';
import 'package:flutter_test_app/article.dart';
import 'package:flutter_test_app/news_service.dart';

class NewsChangeNotifier extends ChangeNotifier {
  late final NewsService _newsService;
  NewsChangeNotifier(this._newsService);

  final List<Article> _articles = [];
  List<Article> get article => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    print('calll');
    _isLoading = true;
    notifyListeners();
    var list = await _newsService.getArticles();
    _articles.addAll(list);
    _isLoading = false;
    notifyListeners();
  }
}
