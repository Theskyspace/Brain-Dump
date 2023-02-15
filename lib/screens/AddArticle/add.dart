import 'dart:developer';

import 'package:braindump/main.dart';
import 'package:braindump/model/articles.dart';
import 'package:braindump/screens/home/home.dart';
import 'package:braindump/theme/app_color.dart';
import 'package:braindump/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:string_validator/string_validator.dart';

class AddScreen extends StatefulWidget {
  String? url;
  AddScreen({this.url = ""});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Map? _urlPreviewData;

  @override
  void initState() {
    super.initState();
    _getUrlData();
  }

  void _getUrlData() async {
    if (!isURL(widget.url ?? "")) {
      setState(() {
        _urlPreviewData = null;
      });
      return;
    }
    var response = await get(Uri.parse(widget.url ?? ""));
    if (response.statusCode != 200) {
      if (!this.mounted) {
        return;
      }
      setState(() {
        _urlPreviewData = null;
      });
    }

    log(response.body.toString());

    var document = parse(response.body);
    Map data = {};
    _extractOGData(document, data, "og:title");
    _extractOGData(document, data, 'og:description');
    _extractOGData(document, data, 'og:site_name');
    _extractOGData(document, data, 'og:image');

    log(data.toString());

    if (data.isNotEmpty) {
      setState(() {
        _urlPreviewData = data;
        log("Data is added ${data["og:title"]}");
      });
    }
  }

  void _extractOGData(Document document, Map data, String parameter) {
    var titleMetaTag = document
        .getElementsByTagName("meta")
        .firstWhereOrNull((meta) => meta.attributes['property'] == parameter);

    if (titleMetaTag != null) {
      data[parameter] = titleMetaTag.attributes['content'];
    } else {
      data[parameter] = "No data";
    }
  }

  @override
  Widget build(BuildContext context) {
    return _urlPreviewData == null
        ? Container(
            color: Colors.amber,
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            child: ListView(
              children: [
                TextFormField(
                  maxLines: null,
                  cursorColor: CustomColors.supressedTextColor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _urlPreviewData?["og:title"] ?? "",
                    hintMaxLines: 100,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  cursorColor: CustomColors.supressedTextColor,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 210, 210, 210),
                    fontSize: 17,
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        _urlPreviewData?["og:description"] ?? "Description: ",
                    hintMaxLines: 500,
                    hintStyle: const TextStyle(
                      color: CustomColors.supressedTextColor,
                      fontSize: 17,
                    ),
                  ),
                ),

                // TextFormField(
                //   maxLines: null,
                //   cursorColor: CustomColors.supressedTextColor,
                //   style: const TextStyle(
                //     color: Color.fromARGB(255, 210, 210, 210),
                //     fontSize: 17,
                //   ),
                //   autofocus: false,
                //   decoration: const InputDecoration(
                //     border: InputBorder.none,
                //     hintText: "Note: ",
                //     hintStyle: TextStyle(
                //       color: CustomColors.yellowshade,
                //       fontSize: 17,
                //     ),
                //   ),
                // ),
                FloatingActionButton(
                  onPressed: (() async {
                    final article = Article(
                        title: "Hello",
                        content: "Akash",
                        url: 'url',
                        note: "note",
                        date: DateTime.now(),
                        id: 1);

                    await ArticleDatabase.instance.create(article);
                  }),
                )
              ],
            ),
          );
  }
}

extension IternableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
