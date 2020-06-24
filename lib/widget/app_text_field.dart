import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  
  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  final bool isBorder;
  final String error;
  final bool isPassword;

  const AppTextField({
    this.hintText, 
    this.icon, 
    this.controller, 
    this.isBorder = false,
    this.error,
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
        ),
        hintText: this.hintText,
        prefixIcon: this.icon,
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            width: this.isBorder ? 1 : 0,
            style: this.isBorder ? BorderStyle.solid : BorderStyle.none,
          ),
        ),
        errorText: this.error,
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {

  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  final bool isBorder;
  final String error;
  final Function(String) validator;
  final bool isPassword;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;

  const AppTextFormField({
    this.hintText, 
    this.icon, 
    this.controller, 
    this.isBorder = false,
    this.error,
    this.validator,
    this.isPassword = false,
    this.focusNode,
    this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: this.validator,
      obscureText: isPassword,
      focusNode: this.focusNode,
      onFieldSubmitted: this.onSubmitted,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
        ),
        hintText: this.hintText,
        prefixIcon: this.icon,
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
            width: this.isBorder ? 1 : 0,
            style: this.isBorder ? BorderStyle.solid : BorderStyle.none,
          ),
        ),
        errorText: this.error,
      ),
    );
  }
}
