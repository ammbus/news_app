// lib/presentation/blocs/news_event.dart

part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class FetchNews extends NewsEvent {
  @override
  List<Object> get props => [];
}

class SearchNewsEvent extends NewsEvent {
  final String query;

  SearchNewsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class FetchFavorites extends NewsEvent {
  @override
  List<Object> get props => [];
}

class UpdateFavoriteStatus extends NewsEvent {
  final int id;
  final bool isFavorite;

  UpdateFavoriteStatus({required this.id, required this.isFavorite});

  @override
  List<Object> get props => [id, isFavorite];
}
