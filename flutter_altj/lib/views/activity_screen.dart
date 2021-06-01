import 'package:flutter/material.dart';
import 'package:flutter_altj/views/activities/meeting.dart';
import 'package:flutter_altj/views/activities/schedule.dart';
import 'package:flutter_altj/views/activities/tasks.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _currentIndex = 0;
  final List<String> appBarTitle = ["Schedule", "Tasks", "Meeting"];
  final List<Widget> _activityChildren = [ScheduleScreen(), TasksScreen(), MeetingScreen()];

  void bottomTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            appBarTitle[_currentIndex],
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              color: Color(0xFFD78B0D),
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFF67D),
        iconTheme: IconThemeData(color: Color(0xFFD78B0D)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: bottomTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFEEE75),
        selectedItemColor: Color(0xFFD78B0D),
        unselectedItemColor: Color(0xFFD78B0D),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
        selectedIconTheme: IconThemeData(size: 30),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
            backgroundColor: _currentIndex == 0 ? Color(0xFFFFD800) : Color(0xFFFEEE75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Tasks",
            backgroundColor: _currentIndex == 1 ? Color(0xFFFFD800) : Color(0xFFFEEE75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Meeting",
            backgroundColor: _currentIndex == 2 ? Color(0xFFFFD800) : Color(0xFFFEEE75),
          ),
        ],
      ),
      body: _activityChildren[_currentIndex],
    );
  }
}
