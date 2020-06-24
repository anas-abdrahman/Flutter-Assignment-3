import 'dart:async';

import 'package:assignment_2/bloc/base_bloc.dart';
import 'package:assignment_2/bloc/bloc_result.dart';
import 'package:assignment_2/firebase/auth.dart';
import 'package:assignment_2/model/user.dart';

class RegisterBloc extends BaseBloc{

  final _registrationController = StreamController<BlocResult<void>>();
  final _emailController = StreamController<BlocResult<void>>();
  final _passwordController = StreamController<BlocResult<void>>();
  final _phoneController = StreamController<BlocResult<void>>();
  final _nameController = StreamController<BlocResult<void>>();

  Stream<BlocResult<void>> get registrationStream => _registrationController.stream;
  
  Stream<BlocResult<void>> get emailStream => _emailController.stream;
  Stream<BlocResult<void>> get passwordStream => _passwordController.stream;
  Stream<BlocResult<void>> get phoneStream => _phoneController.stream;
  Stream<BlocResult<void>> get nameStream => _nameController.stream;


   String name = '';

  register({User user, String password}) async {

    _nameController.add(BlocResult.init());
    _emailController.add(BlocResult.init());
    _phoneController.add(BlocResult.init());
    _passwordController.add(BlocResult.init());

    if (user.name.isEmpty) _nameController.add(BlocResult.empty());
    
    if (user.email.isEmpty) _emailController.add(BlocResult.empty());
    
    if (user.phone.isEmpty) _phoneController.add(BlocResult.empty());

    if (password.isEmpty) _passwordController.add(BlocResult.empty());
    
    if (user.email.isEmpty || user.name.isEmpty || user.phone.isEmpty || password.isEmpty) return;

      //////////////////////////////////////////////

    _registrationController.add(BlocResult.init());

    Auth.signUp(user, password).then((uuid){

      if(uuid.isNotEmpty){

        _registrationController.add(BlocResult.success());

      }else{

        _registrationController.add(BlocResult.empty());

      }

    }).catchError((error){

        if(error.code != null && error.message != null){
          _registrationController.add(BlocResult.errors(error.code, error.message));
        }else{
          _registrationController.add(BlocResult.error(error));
        }

    });    

  }

  @override
  void dispose() {

    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _passwordController.close();
    _registrationController.close();

  }

}