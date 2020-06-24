import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AppLoader extends StatelessWidget {
  
  final bool showLoading;
  final Widget child;

  AppLoader({this.showLoading = false, this.child});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Colors.black,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      inAsyncCall: this.showLoading,
      child: this.child,
    );
  }
}
