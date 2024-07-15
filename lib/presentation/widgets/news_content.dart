// lib/presentation/widgets/news_content.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/domain/entities/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/news_bloc.dart';

class NewsContent extends StatelessWidget {
  final List<Article> articles;

  const NewsContent({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            items: articles.take(5).map((article) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              article.urlToImage ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Text('Image not available'));
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  article.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest News',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('See More'),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
                subtitle: Text('Published at ${article.publishedAt.toString()}'),
                onTap: () {
                  // Handle article tap
                },
                trailing: IconButton(
                  icon: Icon(
                    article.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: article.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (article.id != null) {
                      print('Toggling favorite status for article id: ${article.id}');
                      context.read<NewsBloc>().add(UpdateFavoriteStatus(
                        id: article.id!,
                        isFavorite: !article.isFavorite,
                      ));
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
