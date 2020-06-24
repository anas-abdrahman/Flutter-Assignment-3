import 'package:assignment_3/bloc/bloc_result.dart';
import 'package:assignment_3/bloc/register_bloc.dart';
import 'package:assignment_3/model/user.dart';
import 'package:assignment_3/utils/app_dialog.dart';
import 'package:assignment_3/utils/app_route.dart';
import 'package:assignment_3/utils/app_validate.dart';
import 'package:assignment_3/widget/app_loader.dart';
import 'package:flutter/material.dart';
import '../utils/app_route.dart';
import '../widget/app_icon.dart';
import '../widget/app_button.dart';
import '../widget/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _passFocus = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc = RegisterBloc();
  bool _showLoading = false;

  @override
  void initState() {
    _registerBloc.registrationStream.listen((blocResult) {
      if (blocResult == null || blocResult.state == null) return;

      switch (blocResult.state) {
        case BlocResult.INIT:
          setState(() {
            _showLoading = true;
          });
          break;
        case BlocResult.SUCCESS:
          setState(() {
            _showLoading = false;
          });
          AppDialog.success(
            context,
            'Success!',
            'Register Successfully',
            () => AppRoute.homeScreen(context),
          );
          break;
        case BlocResult.ERROR:
          setState(() {
            _showLoading = false;
          });
          AppDialog.error(
            context,
            blocResult.errorCode,
            blocResult.errorMessage,
          );
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppLoader(
          showLoading: _showLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Hero(
                        tag: 'logoMalakat',
                        child: AppIcons.logoMalakat,
                      ),
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 50),
                    AppTextFormField(
                      hintText: 'Name',
                      icon: Icon(Icons.account_circle),
                      controller: _nameController,
                      isBorder: true,
                      validator: AppValidator.validateName,
                      focusNode: _nameFocus,
                    ),
                    SizedBox(height: 10),
                    AppTextFormField(
                      hintText: 'Email Address',
                      icon: Icon(Icons.email),
                      controller: _emailController,
                      isBorder: true,
                      validator: AppValidator.validateEmail,
                      focusNode: _emailFocus,
                    ),
                    SizedBox(height: 10),
                    AppTextFormField(
                      hintText: 'Phone',
                      icon: Icon(Icons.phone_android),
                      controller: _phoneController,
                      isBorder: true,
                      validator: AppValidator.validatePhone,
                      focusNode: _phoneFocus,
                    ),
                    SizedBox(height: 10),
                    AppTextFormField(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                      controller: _passController,
                      isBorder: true,
                      isPassword: true,
                      validator: AppValidator.validatePassword,
                      focusNode: _passFocus,
                    ),
                    SizedBox(height: 40),
                    AppButton(
                      text: 'Register',
                      onPressed: () {

                        _nameFocus.unfocus();
                        _emailFocus.unfocus();
                        _phoneFocus.unfocus();
                        _passFocus.unfocus();
                        
                        final FormState form = _formKey.currentState;

                        if (form.validate()) {

                          final name  = _nameController.text;
                          final email = _emailController.text;
                          final phone = _phoneController.text;
                          final pass  = _passController.text;

                          _registerBloc.register(
                            user: User(name: name, email: email, phone: phone),
                            password: pass,
                          );

                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
