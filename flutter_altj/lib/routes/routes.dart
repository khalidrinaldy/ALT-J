import 'package:flutter/material.dart';
import 'package:flutter_altj/views/home_screen.dart';
import 'package:flutter_altj/views/login_screen.dart';
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