import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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

  static Future<File?> pickImage() async {
    try {
      final filePicker = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (filePicker != null) {
        return File(filePicker.files.first.xFile.path);
      }
      return null;
    } catch (c) {
      return null;
    }
  }

  static Future<File?> pickAudio() async {
    try {
      final audioPicker = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (audioPicker != null) {
        return File(audioPicker.files.first.xFile.path);
      }
      return null;
    } catch (c) {
      return null;
    }
  }

  static String rgbToHex(Color color) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  static Color hexToColor(String hex) {
    return Color(int.parse(hex, radix: 16) + 0xFF000000);
  }
}
