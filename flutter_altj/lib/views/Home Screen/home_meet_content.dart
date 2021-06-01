import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altj/models/meeting_model.dart';
import 'package:flutter_altj/models/tasks_model.dart';
import 'package:intl/intl.dart';

//Widget to show Today meets
class HomeMeetContent extends StatefulWidget {
  final List<QueryDocumentSnapshot> document;
  final List<Meeting> meets;
  final Function refresh;
  HomeMeetContent(this.document, this.meets, this.refresh);

  @override
  _HomeMeetContentState createState() => _HomeMeetContentState();
}

class _HomeMeetContentState extends State<HomeMeetContent> {
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
          itemCount: widget.meets.length,
          itemBuilder: (context, index) {
            if (widget.meets.length == 0) {
              return Container(
                height: 26,
                margin: EdgeInsets.only(top: 23, left: 23, bottom: 4),
                alignment: Alignment.center,
                child: Text(
                  "No Meets",
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
                                    "${DateFormat("dd/MM/yyyy").format(widget.meets[index].schedule.toDate())}",
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
                                    "${DateFormat("kk:mm").format(widget.meets[index].schedule.toDate())}",
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
                              "${widget.meets[index].activity}",
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
                          "meeting": FieldValue.arrayUnion([
                            {
                              "activity": widget.meets[index].activity,
                              "ormawa": widget.meets[index].ormawa,
                              "schedule": widget.meets[index].schedule,
                              "check": !widget.meets[index].check,
                            }
                          ])
                        });
                        await users.doc(widget.document[0].id).update({
                          "meeting": FieldValue.arrayRemove([
                            {
                              "activity": widget.meets[index].activity,
                              "ormawa": widget.meets[index].ormawa,
                              "schedule": widget.meets[index].schedule,
                              "check": widget.meets[index].check,
                            }
                          ])
                        });
                        widget.refresh();
                      },
                      child: Container(
                          height: 38,
                          width: 38,
                          child: widget.meets[index].check ? Image.asset("assets/img/checked.png") : Image.asset("assets/img/unchecked.png")),
                    )
                  ],
                ),
              );
            }
          },
        )
      ],
    );
  }
}
