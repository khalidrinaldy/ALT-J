import 'package:flutter/material.dart';
import 'package:flutter_altj/views/home_screen.dart';
import 'package:flutter_altj/views/login_screen.dart';
import 'package:flutter_altj/views/register_screen.dart';
import 'package:flutter_altj/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFFEE9B0F)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}