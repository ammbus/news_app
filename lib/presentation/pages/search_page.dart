import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/news_bloc.dart';
import 'package:news_app/domain/entities/article.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Articles',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context.read<NewsBloc>().add(SearchNewsEvent(query: _searchController.text));
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NewsLoaded) {
                    return SearchResult(articles: state.articles);
                  } else if (state is NewsError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final List<Article> articles;

  const SearchResult({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
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
          subtitle: Text(article.description),
          onTap: () {
            // Handle article tap
          },
        );
      },
    );
  }
}
