import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  DateTime dateInput;
  TimeOfDay timeInput;

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2025));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateInput = picked;
      });
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        timeInput = picked;
      });
    }
    print(picked);
  }

  addTask(AsyncSnapshot<QuerySnapshot> snapshot) async {
    if (_taskNameController.text == null || _courseController.text == null || dateInput == null || timeInput == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete the form"),));
    } else {
      var document = snapshot.data.docs;
      final DateTime date = DateTime(dateInput.year, dateInput.month, dateInput.day, timeInput.hour, timeInput.minute);
      final Timestamp timestamp = Timestamp.fromDate(date);
      await users.doc(document[0].id).update({
        "tasks": FieldValue.arrayUnion([
          {"task_name": _taskNameController.text, "course": _courseController.text, "check": false, "deadline": timestamp}
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
            "New Task",
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
                      "Tambah Tugas",
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF614B17)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 33, right: 40, top: 20),
                    child: TextField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                          isDense: false,
                          hintText: "Nama Tugas",
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 33, right: 40, top: 10),
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
                      margin: EdgeInsets.only(left: 33, right: 40, top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deadline",
                        style: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectDate(context),
                      decoration: InputDecoration(
                          isDense: false,
                          hintText: dateInput == null ? "Tanggal" : DateFormat("dd/MM/yyyy").format(dateInput).toString(),
                          hintStyle: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFEE9B0F)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F))),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEE9B0F)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectTime(context),
                      decoration: InputDecoration(
                          isDense: false,
                          hintText: timeInput == null
                              ? "Jam"
                              : "${timeInput.hour < 10 ? "0" + timeInput.hour.toString() : timeInput.hour.toString()}:${timeInput.minute < 10 ? "0" + timeInput.minute.toString() : timeInput.minute.toString()}",
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
                        onPressed: () => addTask(snapshot),
                        child: Text(
                          "Tambah",
                          style: TextStyle(fontFamily: "Montserrat", fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFFFFDF9)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
