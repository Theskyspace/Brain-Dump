import 'package:braindump/model/articles.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ArticleDatabase {
  static final ArticleDatabase instance = ArticleDatabase._init();

  static Database? _database;

  ArticleDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('articles.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $articleTable (
      ${ArticleFeild.title} TEXT NOT NULL,
      ${ArticleFeild.content} TEXT NOT NULL,
      ${ArticleFeild.url} TEXT NOT NULL,
      ${ArticleFeild.note} TEXT NOT NULL,
      ${ArticleFeild.date} TEXT NOT NULL,
      ${ArticleFeild.id} INTEGER PRIMARY KEY AUTOINCREMENT
    )
    ''');
  }

  Future<Article> create(Article article) async {
    final db = await instance.database;

    final id = await db.insert(articleTable, article.toJson());
    return article.copy(id: id);
  }

  Future<Article> readArticle(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      articleTable,
      columns: ArticleFeild.values,
      where: '${ArticleFeild.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Article.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Article>> readAllArticles() async {
    final db = await instance.database;

    const orderBy = '${ArticleFeild.date} DESC';

    final result = await db.query(articleTable, orderBy: orderBy);

    return result.map((json) => Article.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      articleTable,
      where: '${ArticleFeild.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
