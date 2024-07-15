// lib/presentation/blocs/news_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:news_app/domain/usecases/get_news.dart';
import 'package:news_app/data/data_providers/database_helper.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  final SearchNews searchNews;
 
  NewsBloc({required this.getNews, required this.searchNews}) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      print('FetchNews event received');
      emit(NewsLoading());
      try {
        final articles = await getNews();
        emit(NewsLoaded(articles: articles));
        print('FetchNews success: ${articles.length} articles loaded');
      } catch (e) {
        emit(NewsError(message: e.toString()));
        print('FetchNews error: $e');
      }
    });

    on<SearchNewsEvent>((event, emit) async {
      print('SearchNewsEvent event received with query: ${event.query}');
      emit(NewsLoading());
      try {
        final articles = await searchNews(event.query);
        emit(NewsLoaded(articles: articles));
        print('SearchNewsEvent success: ${articles.length} articles found');
      } catch (e) {
        emit(NewsError(message: e.toString()));
        print('SearchNewsEvent error: $e');
      }
    });

    on<FetchFavorites>((event, emit) async {
      print('FetchFavorites event received');
      emit(NewsLoading());
      try {
        final dbHelper = DatabaseHelper();
        final favoriteArticles = await dbHelper.getFavoriteArticles();
        emit(FavoritesLoaded(favoriteArticles: favoriteArticles));
        print('FetchFavorites success: ${favoriteArticles.length} favorite articles loaded');
      } catch (e) {
        emit(NewsError(message: e.toString()));
        print('FetchFavorites error: $e');
      }
    });

    on<UpdateFavoriteStatus>((event, emit) async {
      print('UpdateFavoriteStatus event received for article id: ${event.id} to ${event.isFavorite}');
      try {
        final dbHelper = DatabaseHelper();
        await dbHelper.updateFavoriteStatus(event.id, event.isFavorite);
        print('UpdateFavoriteStatus success');
        
        // Fetch the updated list of favorite articles
        final favoriteArticles = await dbHelper.getFavoriteArticles();
        emit(FavoritesLoaded(favoriteArticles: favoriteArticles));
        print('Favorites reloaded: ${favoriteArticles.length} articles');
      } catch (e) {
        emit(NewsError(message: e.toString()));
        print('UpdateFavoriteStatus error: $e');
      }
    });
  }
}
