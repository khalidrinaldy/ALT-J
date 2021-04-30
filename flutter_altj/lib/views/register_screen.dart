import 'package:flutter/material.dart';
import 'dart:math' as math;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Stack(
        children: [
          Container(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ClipRect(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.73,
                    child: Image.asset(
                      "assets/img/top_register.png",
                    ),
                  ),
                ),
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
            ]),
          ),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(34, 10, 100, 0),
                width: 250,
                height: 24,
                child: Text(
                  "HALO Pengguna Baru!",
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFD78B0D)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(34, 0, 0, 0),
                width: 320,
                height: 75,
                child: Row(
                  children: [
                    Container(
                      width: 195,
                      height: 24,
                      child: Text(
                        "Selamat Datang di",
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFD78B0D)),
                      ),
                    ),
                    Container(
                      width: 115,
                      height: 75,
                      child: Image.asset(
                        "assets/img/logo1.png",
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 35,
                            minHeight: 25,
                          ),
                          isDense: false,
                          hintText: "Email",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 35,
                            minHeight: 25,
                          ),
                          isDense: false,
                          hintText: "Username",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 35,
                            minHeight: 25,
                          ),
                          isDense: false,
                          hintText: "Password",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 35,
                            minHeight: 25,
                          ),
                          isDense: false,
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 33, left: 39, right: 39),
                width: 335,
                height: 42,
                decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: Offset(0, 4))]),
                child: ElevatedButton(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFFEFACD), height: 1.2),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {},
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 15,
                    width: 150,
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Sudah punya akun?",
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFEE9B0F)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 39, right: 39),
                    width: 207,
                    height: 42,
                    decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: Offset(0, 4))]),
                    child: ElevatedButton(
                      child: Text(
                        "Log In",
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFFEFACD), height: 1.2),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}