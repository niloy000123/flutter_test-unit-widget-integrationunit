import 'package:flutter/material.dart';
import 'package:flutter_test_app/article_page.dart';
import 'package:flutter_test_app/news_change_notification.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<NewsChangeNotifier>().getArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news"),
      ),
      body: Consumer<NewsChangeNotifier>(builder: ((context, provider, child) {
        if (provider.isLoading) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: provider.article.length,
          itemBuilder: (context, index) {
            final article = provider.article[index];
            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () {
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticlePage(article: article.content!),
                  );
                },
                child: ListTile(
                  title: Text(article.title!),
                  subtitle: Text(
                    article.content!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        );
      })),
    );
  }
}
