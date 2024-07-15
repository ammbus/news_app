class Article {
  final int? id;
  final String? author;
  final String title;
  final String description;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final String url;
  final bool isFavorite;

  Article({
    this.id,
    this.author,
    required this.title,
    required this.description,
    required this.publishedAt,
    this.urlToImage,
    this.content,
    required this.url,
    this.isFavorite = false,
  });
}
