import 'package:flutter/material.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/data_providers/database_helper.dart';

class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: DatabaseHelper().getSavedArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No saved articles.'));
          } else {
            final articles = snapshot.data!;
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
                  subtitle: Text('Published at ${article.publishedAt.toString()}'),
                  onTap: () {
                    // Handle article tap
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      DatabaseHelper().deleteArticle(article.id!);
                      // Refresh the state to reflect deletion
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
