import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(
    BuildContext context,
    String content,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(content), backgroundColor: bgColor),
      );
  }
}
