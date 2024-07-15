// lib/presentation/pages/main_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:news_app/data/data_providers/news_api.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';
import 'package:news_app/domain/usecases/get_news.dart';
import 'package:news_app/presentation/blocs/news_bloc.dart';
import 'package:news_app/presentation/pages/home_page.dart';
import 'package:news_app/presentation/pages/search_page.dart';
import 'package:news_app/presentation/pages/saved_page.dart';
import 'package:news_app/presentation/pages/account_page.dart';
import 'package:news_app/presentation/pages/settings_page.dart';
import 'package:news_app/presentation/pages/favorites_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    SavedPage(),
    AccountPage(),
    SettingsPage(),
    FavoritesPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(
        getNews: GetNews(repository: NewsRepositoryImpl(newsApi: NewsApi())),
        searchNews: SearchNews(repository: NewsRepositoryImpl(newsApi: NewsApi())),
      ),
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.orange,
          color: Color.fromARGB(255, 6, 40, 120),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.bookmark, size: 30),
            Icon(Icons.account_circle, size: 30),
            Icon(Icons.settings, size: 30),
            Icon(Icons.favorite, size: 30), // Add this line
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
