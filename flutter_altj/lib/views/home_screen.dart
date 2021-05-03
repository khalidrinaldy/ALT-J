import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

DateTime now = new DateTime.now();
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;


  String day = "${now.day < 10 ? "0"+now.day.toString() : now.day.toString()}";
  String month = "${now.month < 10 ? "0"+now.month.toString() : now.month.toString()}";

  DocumentSnapshot userObject;

  Future<void> getUser() async{
    final documents = await db.collection('users').where('email', isEqualTo: _firebaseAuth.currentUser.email.toString()).get();
    print(documents.docs.first.data());
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getUser();
  }

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
          Column(
            children: [
              Container(
                width: 316,
                height: 45,
                margin: EdgeInsets.fromLTRB(34, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      height: 28,
                      child: Text.rich(
                        TextSpan(
                          text: "Hello, ${_firebaseAuth.currentUser.email.substring(0,12)}!",
                          style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 23, color: Color(0xFFD78B0D)),
                        )
                      )
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 37,
                        height: 44,
                        child: Image.asset(
                          "assets/img/person.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 0,
                width: 316,
                margin: EdgeInsets.fromLTRB(34, 0, 0, 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFD78B0D),
                    width: 1.5
                  )
                ),
              ),
              Container(
                width: 316,
                height: 45,
                margin: EdgeInsets.fromLTRB(34, 0, 0, 10),
                child: Text(
                  "Today, $day/$month/${now.year}",
                  style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 23, color: Color(0xFFD78B0D)),
                )
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
