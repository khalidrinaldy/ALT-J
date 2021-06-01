import 'package:flutter/material.dart';

DateTime now = new DateTime.now();
String day = "${now.day < 10 ? "0" + now.day.toString() : now.day.toString()}";
String month = "${now.month < 10 ? "0" + now.month.toString() : now.month.toString()}";

//Widget to show Home Title
class HomeTitle extends StatelessWidget {
  HomeTitle(this.userDocument);

  final Map<String, dynamic> userDocument;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 316,
          height: 45,
          margin: EdgeInsets.fromLTRB(23, 20, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                height: 28,
                child: Text.rich(
                  TextSpan(
                    text: "Hello, ${userDocument['username']}!",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      color: Color(0xFFD78B0D),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: Container(
                  width: 37,
                  height: 44,
                  child: Image.asset(
                    "assets/img/person.png",
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0,
          width: 316,
          margin: EdgeInsets.fromLTRB(23, 0, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFD78B0D), width: 1.5),
          ),
        ),
        Container(
          width: 316,
          height: 45,
          margin: EdgeInsets.fromLTRB(23, 0, 0, 10),
          child: Text(
            "Today, $day/$month/${now.year}",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              fontSize: 23,
              color: Color(0xFFD78B0D),
            ),
          ),
        ),
      ],
    );
  }
}