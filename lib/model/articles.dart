import 'package:flutter/cupertino.dart';

const String articleTable = "articles";

class ArticleFeild {
  static const List<String> values = [id, title, content, url, note, date];

  static const id = "_id";
  static const title = "title";
  static const content = "content";
  static const url = "url";
  static const note = "note";
  static const date = "date";
}

class Article {
  final String title;
  final String content;
  final String url;
  final String note;
  final DateTime date;
  final int? id;

  Article({
    required this.title,
    required this.content,
    required this.url,
    required this.note,
    required this.date,
    required this.id,
  });

  Map<String, Object?> toJson() => {
        ArticleFeild.id: id,
        ArticleFeild.title: title,
        ArticleFeild.content: content,
        ArticleFeild.url: url,
        ArticleFeild.note: note,
        ArticleFeild.date: date.toIso8601String(),
      };

  static Article fromJson(Map<String, Object?> json) => Article(
        id: json[ArticleFeild.id] as int?,
        title: json[ArticleFeild.title] as String,
        content: json[ArticleFeild.content] as String,
        url: json[ArticleFeild.url] as String,
        note: json[ArticleFeild.note] as String,
        date: DateTime.parse(json[ArticleFeild.date] as String),
      );
  Article copy({
    String? title,
    String? content,
    String? url,
    String? note,
    DateTime? date,
    int? id,
  }) =>
      Article(
        id: id,
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url,
        note: note ?? this.note,
        date: date ?? this.date,
      );
}
