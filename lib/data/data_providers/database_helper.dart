import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_app/data/models/article_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'news_app.db');

    return await openDatabase(
      dbPath,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE articles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            author TEXT,
            title TEXT,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('''
            ALTER TABLE articles ADD COLUMN isFavorite INTEGER DEFAULT 0
          ''');
        }
      },
    );
  }

  Future<void> saveArticle(ArticleModel article) async {
    final db = await database;
    await db.insert('articles', article.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ArticleModel>> getSavedArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');

    return List.generate(maps.length, (i) {
      return ArticleModel.fromJson(maps[i]);
    });
  }

  Future<List<ArticleModel>> getFavoriteArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles', where: 'isFavorite = ?', whereArgs: [1]);

    return List.generate(maps.length, (i) {
      print('Fetched favorite article with id: ${maps[i]['id']}');
      return ArticleModel.fromJson(maps[i]);
    });
  }

  Future<void> deleteArticle(int id) async {
    final db = await database;
    await db.delete('articles', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearArticles() async {
    final db = await database;
    await db.delete('articles');
  }

  Future<void> updateFavoriteStatus(int id, bool isFavorite) async {
    final db = await database;
    print('Updating favorite status in database for article id: $id to ${isFavorite ? 1 : 0}');
    await db.update(
      'articles',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
