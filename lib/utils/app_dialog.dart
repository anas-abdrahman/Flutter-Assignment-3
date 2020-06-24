import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppDialog {

  static success(BuildContext context, String title, String message, Function onPressed) {

    return Alert(
      context: context,
      type: AlertType.success,
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 16
        ),
        descStyle: TextStyle(
          fontSize: 14
        ),
      ),
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: onPressed,
          color: Colors.green,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
    
  }

  static error(BuildContext context, String title, String message) {

    return Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 16
        ),
        descStyle: TextStyle(
          fontSize: 14
        ),
      ),
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
    
  }
}