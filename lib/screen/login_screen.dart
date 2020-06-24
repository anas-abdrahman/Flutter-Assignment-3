import 'package:assignment_3/bloc/bloc_result.dart';
import 'package:assignment_3/bloc/login_bloc.dart';
import 'package:assignment_3/model/user.dart';
import 'package:assignment_3/utils/app_dialog.dart';
import 'package:assignment_3/utils/app_route.dart';
import 'package:assignment_3/utils/app_validate.dart';
import 'package:assignment_3/widget/app_loader.dart';
import 'package:flutter/material.dart';
import '../widget/app_icon.dart';
import '../widget/app_button.dart';
import '../widget/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode _emailFocus = FocusNode();
  FocusNode _passFocus = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginBloc _loginBloc = LoginBloc();
  bool _showLoading = false;

  @override
  void initState() {
    _loginBloc.registrationStream.listen((blocResult) {
      if (blocResult == null || blocResult.state == null) return;

      switch (blocResult.state) {
        case BlocResult.INIT:
          setState(() {
            _showLoading = true;
          });
          break;
        case BlocResult.SUCCESS:
          AppRoute.homeScreen(context);
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
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 50),
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
                      text: 'Login',
                      onPressed: () async {

                        _emailFocus.unfocus();
                        _passFocus.unfocus();

                        final FormState form = _formKey.currentState;

                        if (form.validate()) {

                          final email = _emailController.text;
                          final password = _passController.text;

                          _loginBloc.login(
                            user: User(email: email),
                            password: password,
                          );

                        }

                      },
                    ),
                    SizedBox(height: 30),
                    Text('Forgot password?'),
                    SizedBox(height: 60),
                    InkWell(
                      child: Text('Create an Account'),
                      onTap: () => AppRoute.registerScreen(context),
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
