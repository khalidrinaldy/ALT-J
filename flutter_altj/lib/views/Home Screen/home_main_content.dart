import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:flutter_altj/views/Home%20Screen/home_deadlinemeet_content.dart';
import 'package:flutter_altj/views/Home%20Screen/home_title.dart';
import 'package:intl/intl.dart';

//Widget Home Main Content
class HomeContent extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  HomeContent(this.users, this.refresh);
  CollectionReference users;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: users.where('email', isEqualTo: _firebaseAuth.currentUser.email).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //if there is an error when get the data
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        //if waiting for data, show progress indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        //Set up the document Json
        var document = snapshot.data.docs;
        var userDocument = document[0].data();

        //Set task data and push to the tasks array
        List<Task> tasks = [];
        for (var t in userDocument["tasks"]) {
          Task task = Task(t["task_name"], t["course"], t["deadline"], t["check"]);
          tasks.add(task);
        }
        //Sort tasks array then filter tasks where task's deadline has same date as today
        tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
        tasks = tasks.where((item) => DateFormat("dd/MM/yyyy").format(item.deadline.toDate()) == DateFormat('dd/MM/yyyy').format(now)).toList();

        //Set meet data and push to the meets array
        List<Meeting> meets = [];
        for (var m in userDocument["meeting"]) {
          Meeting meet = Meeting(m["activity"], m["ormawa"], m["schedule"], m["check"]);
          meets.add(meet);
        }
        //Sort meets array then filter meets where meet's schedule has same date as today
        meets.sort((a, b) => a.schedule.compareTo(b.schedule));
        meets = meets.where((item) => DateFormat("dd/MM/yyyy").format(item.schedule.toDate()) == DateFormat('dd/MM/yyyy').format(now)).toList();

        return Column(
          children: [
            HomeTitle(userDocument),
            HomeDeadlineMeetContent(document, tasks, meets, refresh),
            //_buildManageActivityButton(),
          ],
        );
      },
    );
  }
}