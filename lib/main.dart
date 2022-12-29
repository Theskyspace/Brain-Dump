import 'dart:developer';
import 'package:braindump/screens/home/home.dart';
import 'package:braindump/theme/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0XFF131313),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white, fontFamily: "Times"),
          headline2: TextStyle(color: Colors.white, fontFamily: "Times"),
          bodyText2: TextStyle(color: Colors.white, fontFamily: "Times"),
          subtitle1: TextStyle(color: Colors.white, fontFamily: "Times"),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0XFF161616),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/images/brainlogo.png',
            fit: BoxFit.contain,
            height: 35,
          ),
          shape: const Border(
              bottom: BorderSide(color: CustomColors.bordercolor, width: 0.5)),
        ),
        body: const HomePage(),
      ),
    );
  }
}
