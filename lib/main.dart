import 'package:chat_application_with_backend_practice1/Pages/home_page.dart';
import 'package:chat_application_with_backend_practice1/Pages/pages.dart';
import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // theme: AppTheme.light(),
      // darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Chat Application Practice',      
      home: HomePage(),
    );
  }
}