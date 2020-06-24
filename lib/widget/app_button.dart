import 'package:flutter/material.dart';
import '../style/app_color.dart';

class AppButton extends StatelessWidget {
  
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const AppButton({@required this.text, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      minWidth: double.infinity,
      child: FlatButton(
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: this.color ?? AppColor.primaryColor),
        ),
        child: Text(this.text),
        color: this.color ?? AppColor.primaryColor,
        onPressed: this.onPressed,
      ),
    );
  }
}
