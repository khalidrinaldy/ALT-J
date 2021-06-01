import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:intl/intl.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: FutureBuilder(
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

            List<Meeting> meets = [];
            for (var m in userDocument["meeting"]) {
              Meeting meet = Meeting(m["activity"], m["ormawa"], m["schedule"], m["check"]);
              meets.add(meet);
            }
            meets.sort((a, b) => a.schedule.compareTo(b.schedule));
            meets = meets.where((item) => item.schedule.seconds > Timestamp.fromDate(DateTime.now()).seconds).toList();
            return ListView.builder(
                itemCount: meets.length,
                itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 15),
                      width: 364,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE7B75A),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 66,
                            ),
                            child: Container(
                              width: 364,
                              decoration: BoxDecoration(
                                color: Color(0xFFE7B75A),
                                border: Border.all(
                                  color: Color(0xFFE7B75A),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Text.rich(
                                  TextSpan(
                                    text: meets[index].activity,
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: 364,
                              height: 27,
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xFFE7B75A),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(meets[index].schedule.toDate()).toString(),
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                                  ),
                                  Container(
                                    width: 60,
                                  ),
                                  Text(
                                    DateFormat("kk:mm").format(meets[index].schedule.toDate()).toString(),
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE7B75A),
        foregroundColor: Color(0xFFFEFACD),
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => Navigator.pushNamed(context, '/addMeeting').then((value) => setState(() {})),
      ),
    );
  }
}
