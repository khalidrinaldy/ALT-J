import 'dart:convert';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:flutter_altj/views/Home%20Screen/home_background.dart';
import 'package:flutter_altj/views/Home%20Screen/home_main_content.dart';
import 'package:flutter_altj/views/Home%20Screen/home_title.dart';
import 'package:intl/intl.dart';
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
  CollectionReference users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance.collection('users');
  }

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Stack(
        children: [
          HomeBackground(),
          HomeContent(users, refresh),
          _buildManageActivityButton(),
        ],
      ),
    );
  }

  Widget _buildManageActivityButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 280,
        height: 80,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/activity').then((value) => setState(() {})),
          child: Text(
            "Manage Activity",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFDF9),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color(0xFFEE9B0F),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(52),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
