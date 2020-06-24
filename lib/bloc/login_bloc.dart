import 'dart:async';

import 'package:assignment_2/bloc/base_bloc.dart';
import 'package:assignment_2/bloc/bloc_result.dart';
import 'package:assignment_2/firebase/auth.dart';
import 'package:assignment_2/model/user.dart';

class LoginBloc extends BaseBloc{

  final _loginController = StreamController<BlocResult<void>>();
  final _emailController = StreamController<BlocResult<void>>();
  final _passwordController = StreamController<BlocResult<void>>();

  Stream<BlocResult<void>> get registrationStream => _loginController.stream;
  
  Stream<BlocResult<void>> get emailStream => _emailController.stream;
  Stream<BlocResult<void>> get passwordStream => _passwordController.stream;

  login({User user, String password}) async {

    _emailController.add(BlocResult.init());
    _passwordController.add(BlocResult.init());
    
    if (user.email.isEmpty) _emailController.add(BlocResult.empty());
    
    if (password.isEmpty) _passwordController.add(BlocResult.empty());
    
    if (user.email.isEmpty || password.isEmpty) return;

      //////////////////////////////////////////////

    _loginController.add(BlocResult.init());

    Auth.signIn(user, password).then((uuid){

      if(uuid.isNotEmpty){

        _loginController.add(BlocResult.success());

      }else{

        _loginController.add(BlocResult.empty());

      }

    }).catchError((error){

        if(error.code != null && error.message != null){
          _loginController.add(BlocResult.errors(error.code, error.message));
        }else{
          _loginController.add(BlocResult.error(error));
        }

    });    

  }

  @override
  void dispose() {

    _emailController.close();
    _passwordController.close();
    _loginController.close();

  }

}