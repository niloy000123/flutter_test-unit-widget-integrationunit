import 'package:flutter/material.dart';
import 'package:flutter_test_app/news_change_notification.dart';
import 'package:flutter_test_app/news_page.dart';
import 'package:flutter_test_app/news_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: NewsPage(),
      ),
    );
  }
}
