import 'package:flutter/material.dart';
import 'mytext.dart';

class TopButtonBar {
  List<Widget> topButtonBar(String title, addtionTitle, BuildContext context) {
    return [
      const SizedBox(width: 10),
      const Spacer(),
      const SizedBox(width: 10),
      MyText(
        txt:
            "$title${addtionTitle != null && addtionTitle.toString().isNotEmpty ? " - " : ""}${addtionTitle ?? ""}",
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(width: 10),
      InkWell(
        onTap: () {
          // dispose();
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          // ),
        ),
      ),
      const SizedBox(width: 10),
    ];
  }
}
