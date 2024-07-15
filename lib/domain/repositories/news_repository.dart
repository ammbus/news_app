import 'package:news_app/domain/entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getArticles();
  Future<List<Article>> searchArticles(String query);
}
