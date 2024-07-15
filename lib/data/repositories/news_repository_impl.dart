import 'package:news_app/data/data_providers/news_api.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi newsApi;

  NewsRepositoryImpl({required this.newsApi});

  @override
  Future<List<ArticleModel>> getArticles() async {
    return await newsApi.fetchArticles();
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    return await newsApi.searchArticles(query);
  }
}
