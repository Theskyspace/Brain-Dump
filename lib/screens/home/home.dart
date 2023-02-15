import 'package:braindump/model/articles.dart';
import 'package:braindump/screens/home/widgets/contentblock.dart';
import 'package:braindump/utils/database_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshArtcles();
  }

  Future refreshArtcles() async {
    articles = await ArticleDatabase.instance.readAllArticles();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return articles.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ContentBlock(
                title: articles[index].title,
                decs: articles[index].content,
                note: articles[index].note,
                url: articles[index].url,
                id: articles[index].id as int,
              );
            })
        : Center(
            child: SizedBox(
              height: 200,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset("assets/images/hero-bg.png"),
              ),
            ),
          );
  }
}
