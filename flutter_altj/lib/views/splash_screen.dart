import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatelessWidget {
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
