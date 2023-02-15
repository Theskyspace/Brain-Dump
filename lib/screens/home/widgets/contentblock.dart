import 'dart:developer';

import 'package:braindump/theme/app_color.dart';
import 'package:braindump/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ContentBlock extends StatefulWidget {
  final String title;
  final String decs;
  final String note;
  final String url;
  final String author;
  final int id;

  const ContentBlock(
      {Key? key,
      this.title =
          "Clean Code: Writing maintainable, readable code, and code that scales",
      this.decs =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, se Lorem ipsum dolor sit amet, consectetur adipiscing elit, se",
      this.note = "Book recommendation I can read later",
      this.url =
          "https://www.youtube.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882",
      this.author = "Akash Joshi",
      required this.id})
      : super(key: key);

  @override
  State<ContentBlock> createState() => _ContentBlockState();
}

class _ContentBlockState extends State<ContentBlock> {
  late String Hostname;
  @override
  void initState() {
    final urlSource = widget.url;

    final uri = Uri.parse(urlSource);
    Hostname = uri.host; // www.wikipedia.org
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: Container(
        color: Colors.red,
      ),
      background: Container(
        color: const Color(0XFFAEFF5E),
      ),
      onDismissed: ((direction) {
        if (direction == DismissDirection.endToStart) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Brain Cleared a little bit"),
            ),
          );
          ArticleDatabase.instance.delete(widget.id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Article Archived"),
            ),
          );
        }
      }),
      key: const ValueKey<int>(1),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CustomColors.bordercolor, width: 0.5),
          ),
        ),
        margin: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        height: 140,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  "${Hostname.split('.').sublist(1).join(".")} • ${widget.author}",
                  style: const TextStyle(
                    color: CustomColors.supressedTextColor,
                    fontSize: 15,
                  )),
              Text(
                widget.decs,
                style: const TextStyle(
                  color: CustomColors.supressedTextColor,
                  fontSize: 15,
                ),
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Note : ',
                  style:
                      const TextStyle(color: Color(0XFFFFC700), fontSize: 15),
                  children: <InlineSpan>[
                    TextSpan(
                        text: widget.note,
                        style: const TextStyle(
                            color: Color.fromARGB(211, 244, 244, 244)))
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
