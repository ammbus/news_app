import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews({required this.repository});

  Future<List<Article>> call() async {
    return await repository.getArticles();
  }
}

class SearchNews {
  final NewsRepository repository;

  SearchNews({required this.repository});

  Future<List<Article>> call(String query) async {
    return await repository.searchArticles(query);
  }
}
