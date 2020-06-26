import 'package:assignment_3/screen/home_screen.dart';
import 'package:assignment_3/screen/login_screen.dart';
import 'package:assignment_3/screen/profile_screen.dart';
import 'package:assignment_3/screen/register_screen.dart';
import 'package:assignment_3/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {

  static splashScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
    );
  }

  static loginScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (i, ii, iii) => LoginScreen(),
      ),
      (Route<dynamic> route) => false
    );
  }

  static registerScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (i, ii, iii) => RegisterScreen(),
      ),
    );
  }

  static profileScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (i, ii, iii) => ProfileScreen(),
      ),
    );
  }

  static homeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (Route<dynamic> route) => false
    );
  }
  
}
