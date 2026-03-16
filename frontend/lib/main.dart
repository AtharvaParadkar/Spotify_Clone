import 'package:flutter/material.dart';
import 'package:frontend/features/auth/view/pages/signup_page.dart';
import 'package:frontend/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: SignUpPage(),
    );
  }
}