import 'dart:async';
import 'dart:developer';

import 'package:braindump/screens/AddArticle/add.dart';
import 'package:braindump/screens/home/home.dart';
import 'package:braindump/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late StreamSubscription _intentDataStreamSubscription;
  String _sharedText = "";
  bool _isReceiving = false;
  @override
  void initState() {
    // When the app is still in the memory, this will be called when the user shares something
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
        _isReceiving = true;
      });
    }, onError: (err) {
      log("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        if (value != null) {
          _sharedText = value;
          _isReceiving = true;
        }
      });
    });
    super.initState();
  }

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
        body: _isReceiving ? const AddScreen() : const HomePage(),
      ),
    );
  }
}
