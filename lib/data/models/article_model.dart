import 'package:news_app/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    int? id,
    String? author,
    required String title,
    required String description,
    required String url,
    String? urlToImage,
    required DateTime publishedAt,
    String? content,
    bool isFavorite = false,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          publishedAt: publishedAt,
          urlToImage: urlToImage,
          content: content,
          url: url,
          isFavorite: isFavorite,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
      isFavorite: json['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}