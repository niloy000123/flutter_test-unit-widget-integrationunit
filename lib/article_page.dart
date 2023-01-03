import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, required this.article});

  final String article;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(article),
    );
  }
}
