import 'package:assignment_3/firebase/auth.dart';
import 'package:assignment_3/utils/app_route.dart';
import 'package:flutter/material.dart';
import '../utils/app_route.dart';
import '../widget/app_icon.dart';

class SplashScreen extends StatefulWidget {
  @override _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'logoMalakat',
          child: AppIcons.logoMalakat,
        ),
      ),
    );
  }

  checkUser() async {

    Auth.getCurrentUser().then((user) {

      Future.delayed(Duration(seconds: 3)).then((_){
        
          if (user != null) 
          {

            AppRoute.homeScreen(context);

          }else{

            AppRoute.loginScreen(context);

          }
        
      });

    });
  }
}
