import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:intl/intl.dart';

//Widget to show today deadlines
class HomeDeadlineContent extends StatefulWidget {
  final List<QueryDocumentSnapshot> document;
  final List<Task> tasks;
  final Function refresh;
  HomeDeadlineContent(this.document, this.tasks, this.refresh);

  @override
  _HomeDeadlineContentState createState() => _HomeDeadlineContentState();
}

class _HomeDeadlineContentState extends State<HomeDeadlineContent> {
  CollectionReference users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 26,
          margin: EdgeInsets.only(top: 10, left: 23, bottom: 4),
          child: Text(
            "Today Deadlines : ",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        //TODAY TASKS
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            if (widget.tasks.length == 0) {
              return Container(
                height: 26,
                margin: EdgeInsets.only(top: 23, left: 23, bottom: 4),
                alignment: Alignment.center,
                child: Text(
                  "No Task Today",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFFEE9B0F),
                  ),
                ),
              );
            } else {
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
                                    "${DateFormat("dd/MM/yyyy").format(widget.tasks[index].deadline.toDate())}",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Text(
                                    "${DateFormat('kk:mm').format(widget.tasks[index].deadline.toDate())}",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 250,
                            child: Text(
                              "${widget.tasks[index].course}",
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
                      onTap: () async {
                        await users.doc(widget.document[0].id).update({
                          "tasks": FieldValue.arrayUnion([
                            {
                              "task_name": widget.tasks[index].task_name,
                              "course": widget.tasks[index].course,
                              "deadline": widget.tasks[index].deadline,
                              "check": !widget.tasks[index].check,
                            }
                          ])
                        });
                        await users.doc(widget.document[0].id).update({
                          "tasks": FieldValue.arrayRemove([
                            {
                              "task_name": widget.tasks[index].task_name,
                              "course": widget.tasks[index].course,
                              "deadline": widget.tasks[index].deadline,
                              "check": widget.tasks[index].check,
                            }
                          ])
                        });
                        widget.refresh();
                      },
                      child: Container(
                        height: 38,
                        width: 38,
                        child: widget.tasks[index].check ? Image.asset("assets/img/checked.png") : Image.asset("assets/img/unchecked.png"),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
