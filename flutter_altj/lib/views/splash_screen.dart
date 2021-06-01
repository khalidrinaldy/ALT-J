import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

    //Check if user is not exist
    _firebaseAuth.authStateChanges().listen((User user) {
      var isUserNotExist = user == null;

      if (isUserNotExist) {
        Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/login'));
      } else {
        Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/home'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    //Screen Size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRect(
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Image.asset(
                  "assets/img/bottom_splash_screen.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth*0.6,
            height: screenHeight*0.25,
            child: Image.asset(
              "assets/img/logo1.png",
              fit: BoxFit.fill,
            ),
          ),
          ClipRect(
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              child: Image.asset(
                "assets/img/bottom_splash_screen.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
