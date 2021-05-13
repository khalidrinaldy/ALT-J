import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddScheduleScreen extends StatefulWidget {
  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController _courseController = TextEditingController();
  TextEditingController _lectureController = TextEditingController();
  String dayInput;
  TimeOfDay fromInput, toInput;

  selectDayInput(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Color(0xFFFFF67D),
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Tuesday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Wednesday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Thursday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Friday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Saturday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                  Text(
                    "Sunday",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFD78B0D), fontSize: 20),
                  ),
                ],
                onSelectedItemChanged: (value) {
                  setState(() {
                    switch (value) {
                      case 0:
                        setState(() {
                          dayInput = "Monday";
                        });
                        break;
                      case 1:
                        setState(() {
                          dayInput = "Tuesday";
                        });
                        break;
                      case 2:
                        setState(() {
                          dayInput = "Wednesday";
                        });
                        break;
                      case 3:
                        setState(() {
                          dayInput = "Thursday";
                        });
                        break;
                      case 4:
                        setState(() {
                          dayInput = "Friday";
                        });
                        break;
                      case 5:
                        setState(() {
                          dayInput = "Saturday";
                        });
                        break;
                      case 6:
                        setState(() {
                          dayInput = "Sunday";
                        });
                        break;
                      default:
                    }
                  });
                },
              ),
            ));
  }

  selectTimeFrom(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        fromInput = picked;
      });
    }
  }

  selectTimeTo(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        toInput = picked;
      });
    }
  }

  addSchedule(AsyncSnapshot<QuerySnapshot> snapshot) async {
    if (_courseController.text == null || _lectureController.text == null || dayInput == null || fromInput == null || toInput == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please complete the form"),
      ));
    } else {
      var document = snapshot.data.docs;
      await users.doc(document[0].id).update({
        "schedule": FieldValue.arrayUnion([
          {
            "course": _courseController.text,
            "lecture": _lectureController.text,
            "day": dayInput,
            "from": "${fromInput.hour < 10 ? "0" + fromInput.hour.toString() : fromInput.hour.toString()}:${fromInput.minute < 10 ? "0" + fromInput.minute.toString() : fromInput.minute.toString()}",
            "to": "${toInput.hour < 10 ? "0" + toInput.hour.toString() : toInput.hour.toString()}:${toInput.minute < 10 ? "0" + toInput.minute.toString() : toInput.minute.toString()}"
          }
        ])
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "New Schedule",
              style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, color: Color(0xFFD78B0D), fontSize: 24),
            ),
          ),
          backgroundColor: Color(0xFFFFF67D),
          iconTheme: IconThemeData(color: Color(0xFFD78B0D)),
        ),
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

            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                  ],
                ),
                ListView(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 33, top: 19),
                      child: Text(
                        "Tambah Schedule",
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF614B17)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 33, right: 40, top: 20),
                      child: TextField(
                        controller: _courseController,
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: "Mata Kuliah",
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 33, right: 40, top: 10),
                      child: TextField(
                        controller: _lectureController,
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: "Nama Dosen",
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 33, right: 40, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Waktu",
                          style: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 40),
                      child: TextField(
                        readOnly: true,
                        onTap: () => selectDayInput(context),
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: dayInput == null ? "Hari" : dayInput,
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 40),
                      child: TextField(
                        readOnly: true,
                        onTap: () => selectTimeFrom(context),
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: fromInput == null
                                ? "Jam Mulai"
                                : "${fromInput.hour < 10 ? "0" + fromInput.hour.toString() : fromInput.hour.toString()}:${fromInput.minute < 10 ? "0" + fromInput.minute.toString() : fromInput.minute.toString()}",
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 40),
                      child: TextField(
                        readOnly: true,
                        onTap: () => selectTimeTo(context),
                        decoration: InputDecoration(
                            isDense: false,
                            hintText: toInput == null
                                ? "Jam Selesai"
                                : "${toInput.hour < 10 ? "0" + toInput.hour.toString() : toInput.hour.toString()}:${toInput.minute < 10 ? "0" + toInput.minute.toString() : toInput.minute.toString()}",
                            hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 42,
                      margin: EdgeInsets.fromLTRB(100, 50, 100, 0),
                      decoration: BoxDecoration(
                          color: Color(0xFFEE9B0F),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: Offset(0, 4), blurRadius: 4)]),
                      child: ElevatedButton(
                          onPressed: () => addSchedule(snapshot),
                          child: Text(
                            "Tambah",
                            style: TextStyle(fontFamily: "Montserrat", fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFFFFDF9)),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }
}
