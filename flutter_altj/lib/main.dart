import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_altj/routes/routes.dart';
import 'package:flutter_altj/views/home_screen.dart';
import 'package:flutter_altj/views/login_screen.dart';
import 'package:flutter_altj/views/register_screen.dart';
import 'package:flutter_altj/views/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primaryColor: Color(0xFFEE9B0F),
        accentColor: Color(0xFFEE9B0F),
        fontFamily: "Montserrat"
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}