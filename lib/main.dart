import 'package:flutter/material.dart';
import 'package:rs_blog_app/core/theme/theme.dart';
import 'package:rs_blog_app/feature/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage()
    );
  }
}
