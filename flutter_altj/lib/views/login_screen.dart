import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Login Function
  Future<void> logIn() async {

    //Login to firebase
    //Show dialog if there is an error
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) => {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login Success"),
              duration: Duration(seconds: 2),
            )),
            Timer(Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false))
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Screen Size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Stack(
        children: [
          _buildBottomBackground(screenHeight, screenWidth),
          ListView(
            children: [
              Column(
                children: [
                  _buildLogo(screenHeight, screenWidth),
                  _buildForm(),
                ],
              ),
              _buildLoginButton(),
              _buildSignUpLink(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBackground(screenHeight, screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
    );
  }

  Widget _buildLogo(screenHeight, screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.1),
      width: screenWidth * 0.6,
      height: screenHeight * 0.25,
      child: Image.asset(
        "assets/img/logo1.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: 20),
          child: TextField(
            controller: _emailController,
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
              hintStyle: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEE9B0F),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEE9B0F),
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEE9B0F),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: TextField(
            controller: _passwordController,
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
              hintStyle: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEE9B0F),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEE9B0F),
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEE9B0F),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(top: 33, left: 39, right: 39),
      width: 335,
      height: 42,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        child: Text(
          "Log In",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFEFACD),
            height: 1.2,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xFFEE9B0F),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () => logIn(),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 15,
          width: 150,
          margin: EdgeInsets.only(top: 15),
          child: Text(
            "Belum punya akun?",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFEE9B0F),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Container(
            height: 15,
            width: 70,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEE9B0F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
