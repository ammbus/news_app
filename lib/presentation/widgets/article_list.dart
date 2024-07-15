import 'package:flutter/material.dart';
import 'package:news_app/domain/entities/article.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;

  const ArticleList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.description),
        );
      },
    );
  }
}
