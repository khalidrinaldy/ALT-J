import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: FutureBuilder<QuerySnapshot>(
          future: users.where('email', isEqualTo: firebaseAuth.currentUser.email).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var document = snapshot.data.docs;
            var userDocument = document[0].data();

            List<Task> tasks = [];
            for (var t in userDocument["tasks"]) {
              Task task = Task(t["task_name"], t["course"], t["deadline"], t["check"]);
              tasks.add(task);
            }

            tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
            tasks = tasks.where((item) => item.deadline.seconds > Timestamp.fromDate(DateTime.now()).seconds).toList();

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => Container(
                height: 120,
                width: 350,
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFE7B75A),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Due Date",
                            style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 56,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  DateFormat('dd').format(tasks[index].deadline.toDate()).toString(),
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            DateFormat('MMM').format(tasks[index].deadline.toDate()).toString(),
                            style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 0,
                      margin: EdgeInsets.only(left: 22),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Color(0xFFFEFACD),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: tasks[index].task_name,
                              style: TextStyle(fontFamily: "Montserrat", fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            DateFormat('kk:mm').format(tasks[index].deadline.toDate()).toString(),
                            style: TextStyle(fontFamily: "Montserrat", fontSize: 13, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE7B75A),
        foregroundColor: Color(0xFFFEFACD),
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => Navigator.pushNamed(context, '/addTask').then((value) => setState(() {})),
      ),
    );
  }
}
