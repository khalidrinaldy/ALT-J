import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:flutter_altj/views/Home%20Screen/home_deadline_content.dart';
import 'package:flutter_altj/views/Home%20Screen/home_meet_content.dart';

//Today deadlines and meets widget wrapper
class HomeDeadlineMeetContent extends StatelessWidget {
  final List<QueryDocumentSnapshot> document;
  final List<Task> tasks;
  final List<Meeting> meets;
  final Function refresh;
  HomeDeadlineMeetContent(this.document, this.tasks, this.meets, this.refresh);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: [
          HomeDeadlineContent(document, tasks, refresh),
          HomeMeetContent(document, meets, refresh),
        ],
      ),
    );
  }
}