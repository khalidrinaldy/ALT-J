import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    //Screen Size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.8,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.25,
                child: Image.asset(
                  "assets/img/top_register.png",
                  fit: BoxFit.fill,
                ),
              ),
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