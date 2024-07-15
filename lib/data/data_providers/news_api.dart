import 'package:dio/dio.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/utils/constants.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/data_providers/database_helper.dart';

class NewsApi {
  final Dio dio = Dio();

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await dio.get('${Constants.newsBaseUrl}/everything', queryParameters: {
        'q': 'apple',
        'from': '2024-07-13',
        'to': '2024-07-14',
        'sortBy': 'popularity',
        'apiKey': Constants.newsApiKey,
      });

      if (response.statusCode == 200) {
        List articles = response.data['articles'];
        List<ArticleModel> articleModels = articles
            .map((article) => ArticleModel.fromJson(article))
            .where((article) =>
                article.title.isNotEmpty &&
                article.description.isNotEmpty &&
                article.urlToImage != null)
            .toList();

        // local saving :)
        final dbHelper = DatabaseHelper();
        await dbHelper.clearArticles();
        for (var article in articleModels) {
          await dbHelper.saveArticle(article);
        }

        return articleModels;
      } else {
        throw ServerException();
      }
    } on DioException {
      final dbHelper = DatabaseHelper();
      return await dbHelper.getSavedArticles();
    }
  }

  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      final response = await dio.get('${Constants.newsBaseUrl}/everything', queryParameters: {
        'q': query,
        'apiKey': Constants.newsApiKey,
      });

      if (response.statusCode == 200) {
        List articles = response.data['articles'];
        return articles
            .map((article) => ArticleModel.fromJson(article))
            .where((article) =>
                article.title.isNotEmpty &&
                article.description.isNotEmpty &&
                article.urlToImage != null)
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException {
      
      return [];
    }
  }
}
