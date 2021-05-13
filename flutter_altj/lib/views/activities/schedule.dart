import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/schedule_model.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  int _currentDay;
  String title;
  String nameOfDay;

  getDayIndex() {
    String day = DateFormat("EEEE").format(DateTime.now());
    switch (day) {
      case 'Monday':
        setState(() {
          _currentDay = 0;
          title = "Senin";
          nameOfDay = day;
        });
        break;
      case 'Tuesday':
        setState(() {
          _currentDay = 1;
          title = "Selasa";
          nameOfDay = day;
        });
        break;
      case 'Wednesday':
        setState(() {
          _currentDay = 2;
          title = "Rabu";
          nameOfDay = day;
        });
        break;
      case 'Thursday':
        setState(() {
          _currentDay = 3;
          title = "Kamis";
          nameOfDay = day;
        });
        break;
      case 'Friday':
        setState(() {
          _currentDay = 4;
          title = "Jumat";
          nameOfDay = day;
        });
        break;
      case 'Saturday':
        setState(() {
          _currentDay = 5;
          title = "Sabtu";
          nameOfDay = day;
        });
        break;
      case 'Sunday':
        setState(() {
          _currentDay = 6;
          title = "Minggu";
          nameOfDay = day;
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDayIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      body: Row(
        children: [
          Container(
            width: 81,
            height: 542.5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 0;
                      title = "Senin";
                      nameOfDay = "Monday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 0 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "M",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 0 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 1;
                      title = "Selasa";
                      nameOfDay = "Tuesday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 1 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "T",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 1 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 2;
                      title = "Rabu";
                      nameOfDay = "Wednesday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 2 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "W",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 2 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 3;
                      title = "Kamis";
                      nameOfDay = "Thursday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 3 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "T",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 3 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 4;
                      title = "Jumat";
                      nameOfDay = "Friday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 4 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "F",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 4 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 5;
                      title = "Sabtu";
                      nameOfDay = "Wednesday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 5 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "S",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 5 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDay = 6;
                      title = "Minggu";
                      nameOfDay = "Sunday";
                    });
                  },
                  child: Container(
                    width: 81,
                    height: 77,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _currentDay == 6 ? Color(0xFFFFF67D) : Color(0xFFE7B75A),
                        border: Border(top: BorderSide(color: Color(0xFFFEFACD), width: 0.5))),
                    child: Text(
                      "S",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 43, color: _currentDay == 6 ? Color(0xFFE7B75A) : Color(0xFFFFF67D)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
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

              List<Schedule> schedules = [];
              for (var s in userDocument["schedule"]) {
                Schedule schedule = Schedule(s["course"], s["lecture"], s["day"], s["from"], s["to"]);
                schedules.add(schedule);
              }
              schedules = schedules.where((item) => item.day.toString() == nameOfDay).toList();
              schedules.sort((a,b) => a.from.compareTo(b.from));
              print(schedules);

              return Container(
                height: 542.5,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 31, color: Color(0xFF614B17)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      child: Column(
                        children: [
                          Container(
                            width: 310,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFE7B75A),
                                border: Border.all(color: Color(0xFFE7B75A), width: 1),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(38), topRight: Radius.circular(38))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Jam",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Color(0xFFFFF67D)),
                                ),
                                Text(
                                  "Mata Kuliah",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Color(0xFFFFF67D)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 310,
                            height: 420,
                            decoration: BoxDecoration(
                                color: Color(0xFFFEFACD),
                                border: Border.all(color: Color(0xFFE7B75A), width: 1),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(38), bottomRight: Radius.circular(38))),
                            child: ListView.builder(
                              itemCount: schedules.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${schedules[index].from} - ${schedules[index].to}",
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xFF614B17)),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(minHeight: 18),
                                      child: Container(
                                          width: 165,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text.rich(TextSpan(
                                                  text: schedules[index].course,
                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xFF614B17)),
                                                )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await users.doc(document[0].id).update({
                                                    "schedule": FieldValue.arrayRemove([{
                                                      "course":schedules[index].course,
                                                      "lecture": schedules[index].lecture,
                                                      "day": schedules[index].day,
                                                      "from": schedules[index].from,
                                                      "to": schedules[index].to
                                                    }])
                                                  });
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE7B75A),
        foregroundColor: Color(0xFFFEFACD),
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => Navigator.pushNamed(context, '/addSchedule').then((value) => setState(() {})),
      ),
    );
  }
}
