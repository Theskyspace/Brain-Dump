import 'package:braindump/theme/app_color.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Heading",
              hintStyle: TextStyle(
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
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              hintMaxLines: 500,
              hintStyle: TextStyle(
                color: CustomColors.supressedTextColor,
                fontSize: 17,
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
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Note: ",
              hintStyle: TextStyle(
                color: CustomColors.yellowshade,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
