import 'package:flutter/material.dart';
import 'package:flutter_altj/views/activities/add_meeting.dart';
import 'package:flutter_altj/views/activities/add_schedule.dart';
import 'package:flutter_altj/views/activities/add_tasks.dart';
import 'package:flutter_altj/views/activity_screen.dart';
import 'package:flutter_altj/views/Home%20Screen/home_screen.dart';
import 'package:flutter_altj/views/login_screen.dart';
import 'package:flutter_altj/views/profile_screen.dart';
import 'package:flutter_altj/views/register_screen.dart';
import 'package:flutter_altj/views/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
        break;
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
        break;
      case '/activity':
        return MaterialPageRoute(builder: (_) => ActivityScreen());
        break;
      case '/addTask':
        return MaterialPageRoute(builder: (_) => AddTaskScreen());
        break;
      case '/addMeeting':
        return MaterialPageRoute(builder: (_) => AddMeetingScreen());
        break;
      case '/addSchedule':
        return MaterialPageRoute(builder: (_) => AddScheduleScreen());
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Error"),),
        body: Center(child: Text("Error Page"),),
      );
    });
  }
}