import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/login'));
      } else {
        Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/home'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRect(
            child: Container(
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.6,
                  child: Image.asset(
                    "assets/img/bottom_splash_screen.png",
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("assets/img/logo1.png", scale: 1.2,),
          ),
          ClipRect(
            child: Container(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: Image.asset(
                  "assets/img/bottom_splash_screen.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
