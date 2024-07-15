// lib/presentation/pages/favorites_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/news_bloc.dart';
import 'package:news_app/domain/entities/article.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Articles'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            print('Initial state in FavoritesPage, triggering FetchFavorites');
            context.read<NewsBloc>().add(FetchFavorites());
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favoriteArticles.isEmpty) {
              print('No favorite articles found');
              return Center(child: Text('No favorite articles.'));
            }
            print('${state.favoriteArticles.length} favorite articles found');
            return ListView.builder(
              itemCount: state.favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = state.favoriteArticles[index];
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      article.urlToImage ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Image not available'));
                      },
                    ),
                  ),
                  title: Text(article.title),
                  subtitle: Text('Published at ${article.publishedAt.toString()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      context.read<NewsBloc>().add(UpdateFavoriteStatus(id: article.id!, isFavorite: false));
                    },
                  ),
                  onTap: () {
                    // Handle article tap
                  },
                );
              },
            );
          } else if (state is NewsError) {
            print('Error state in FavoritesPage: ${state.message}');
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
