import 'dart:convert';
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

  String day = "${now.day < 10 ? "0" + now.day.toString() : now.day.toString()}";
  String month = "${now.month < 10 ? "0" + now.month.toString() : now.month.toString()}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance.collection('users');
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
          StreamBuilder<QuerySnapshot>(
            stream: users.where('email', isEqualTo: _firebaseAuth.currentUser.email).snapshots(includeMetadataChanges: true),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var userDocument = snapshot.data.docs;
              print(userDocument[0].data());

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
                            child: Text.rich(TextSpan(
                              text: "Hello, ${userDocument[0]['username']}!",
                              style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 23, color: Color(0xFFD78B0D)),
                            ))),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/profile'),
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
                    margin: EdgeInsets.fromLTRB(23, 0, 0, 10),
                    decoration: BoxDecoration(border: Border.all(color: Color(0xFFD78B0D), width: 1.5)),
                  ),
                  Container(
                      width: 316,
                      height: 45,
                      margin: EdgeInsets.fromLTRB(23, 0, 0, 10),
                      child: Text(
                        "Today, $day/$month/${now.year}",
                        style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 23, color: Color(0xFFD78B0D)),
                      )),
                  Container(
                    height: 350,
                    child: ListView(
                      children: [
                        Container(
                          height: 26,
                          margin: EdgeInsets.only(top: 10, left: 23, bottom: 4),
                          child: Text(
                            "Today Deadlines : ",
                            style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        //TODAY TASKS
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: userDocument[0]["tasks"].length,
                          itemBuilder: (context, index) {
                            if (userDocument[0]["tasks"].length == 0) {
                              return Container(
                                height: 26,
                                margin: EdgeInsets.only(top: 23, left: 23, bottom: 4),
                                alignment: Alignment.center,
                                child: Text(
                                  "No Tasks",
                                  style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xFFEE9B0F)),
                                ),
                              );
                            } else {
                              //Simplisitas
                              List tasks = userDocument[0]["tasks"];
                              tasks.sort((a, b) => a["deadline"].compareTo(b["deadline"]));
                              String taskDate = DateFormat('dd/MM/yyyy').format(tasks[index]['deadline'].toDate());
                              String taskHour = DateFormat('kk:mm').format(tasks[index]['deadline'].toDate());
                              String taskCourse = tasks[index]['course'];
                              String taskName = tasks[index]['task_name'];
                              bool taskCheck = tasks[index]['check'];

                              if (DateFormat('dd/MM/yyyy').format(now) == taskDate) {
                                return Container(
                                  width: 335,
                                  height: 76,
                                  margin: EdgeInsets.only(left: 25, top: 13, right: 25),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFDD991C),
                                        width: 1,
                                      ),
                                      color: Color(0xFFFFF67D),
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 18,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "$taskDate",
                                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 15, fontWeight: FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 40),
                                                    child: Text(
                                                      "$taskHour",
                                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 15, fontWeight: FontWeight.w400),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                "$taskCourse",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          users.doc(userDocument[0].id).update({
                                            "tasks": FieldValue.arrayUnion([
                                              {"task_name": taskName, "course": taskCourse, "deadline": tasks[index]['deadline'], "check": !taskCheck}
                                            ])
                                          });
                                          users.doc(userDocument[0].id).update({
                                            "tasks": FieldValue.arrayRemove([
                                              {"task_name": taskName, "course": taskCourse, "deadline": tasks[index]['deadline'], "check": taskCheck}
                                            ])
                                          });
                                        },
                                        child: Container(
                                            height: 38,
                                            width: 38,
                                            child: taskCheck ? Image.asset("assets/img/checked.png") : Image.asset("assets/img/unchecked.png")),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        Container(
                          height: 26,
                          margin: EdgeInsets.only(top: 23, left: 23, bottom: 4),
                          child: Text(
                            "Today Meeting : ",
                            style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: userDocument[0]["meeting"].length,
                          itemBuilder: (context, index) {
                            if (userDocument[0]["meeting"].length == 0) {
                              return Container(
                                height: 26,
                                margin: EdgeInsets.only(top: 23, left: 23, bottom: 4),
                                alignment: Alignment.center,
                                child: Text(
                                  "No Meets",
                                  style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xFFEE9B0F)),
                                ),
                              );
                            } else {
                              //Simplisitas
                              List meets = userDocument[0]["meeting"];
                              meets.sort((a, b) => a["schedule"].compareTo(b["schedule"]));
                              String meetDate = DateFormat('dd/MM/yyyy').format(meets[index]['schedule'].toDate());
                              String meetHour = DateFormat('kk:mm').format(meets[index]['schedule'].toDate());
                              String meetOrmawa = meets[index]['ormawa'];
                              String meetActivity = meets[index]['activity'];
                              bool meetCheck = meets[index]['check'];

                              if (DateFormat('dd/MM/yyyy').format(now) == meetDate) {
                                return Container(
                                  width: 335,
                                  height: 76,
                                  margin: EdgeInsets.only(left: 25, top: 13, right: 25),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFDD991C),
                                        width: 1,
                                      ),
                                      color: Color(0xFFFFF67D),
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 18,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "$meetDate",
                                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 15, fontWeight: FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 40),
                                                    child: Text(
                                                      "$meetHour",
                                                      style: TextStyle(fontFamily: "Montserrat", fontSize: 15, fontWeight: FontWeight.w400),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                "$meetActivity",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          users.doc(userDocument[0].id).update({
                                            "meeting": FieldValue.arrayUnion([
                                              {
                                                "activity": meetActivity,
                                                "ormawa": meetOrmawa,
                                                "schedule": meets[index]['schedule'],
                                                "check": !meetCheck
                                              }
                                            ])
                                          });
                                          users.doc(userDocument[0].id).update({
                                            "meeting": FieldValue.arrayRemove([
                                              {
                                                "activity": meetActivity,
                                                "ormawa": meetOrmawa,
                                                "schedule": meets[index]['schedule'],
                                                "check": meetCheck
                                              }
                                            ])
                                          });
                                        },
                                        child: Container(
                                            height: 38,
                                            width: 38,
                                            child: meetCheck ? Image.asset("assets/img/checked.png") : Image.asset("assets/img/unchecked.png")),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 80,
                    margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      boxShadow: [BoxShadow(
                        offset: Offset(0,4),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.25)
                      )]
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/activity'),
                      child: Text(
                        "Manage Activity",
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFFFFDF9)),
                      ),
                      style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(52))))
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
