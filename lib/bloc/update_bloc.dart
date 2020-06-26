import 'dart:async';

import 'package:assignment_3/bloc/base_bloc.dart';
import 'package:assignment_3/bloc/bloc_result.dart';
import 'package:assignment_3/firebase/auth.dart';
import 'package:assignment_3/model/user.dart';

class UpdateBloc extends BaseBloc{

  final _updateController = StreamController<BlocResult<void>>();
  
  final _emailController = StreamController<BlocResult<void>>();
  final _phoneController = StreamController<BlocResult<void>>();
  final _nameController = StreamController<BlocResult<void>>();

  Stream<BlocResult<void>> get updateStream => _updateController.stream;
  
  Stream<BlocResult<void>> get emailStream => _emailController.stream;
  Stream<BlocResult<void>> get phoneStream => _phoneController.stream;
  Stream<BlocResult<void>> get nameStream => _nameController.stream;

  update({User user}) async {

    _nameController.add(BlocResult.init());
    _emailController.add(BlocResult.init());
    _phoneController.add(BlocResult.init());

    // if (user.name.isEmpty) _nameController.add(BlocResult.empty());
    
    // if (user.email.isEmpty) _emailController.add(BlocResult.empty());
    
    // if (user.phone.isEmpty) _phoneController.add(BlocResult.empty());
    
    // if (user.email.isEmpty || user.name.isEmpty || user.phone.isEmpty) return;

    //   //////////////////////////////////////////////

    _updateController.add(BlocResult.init());

    Auth.setUserFirestore(user).then((uuid){

      _updateController.add(BlocResult.success());

    }).catchError((error){

        if(error.code != null && error.message != null){
          _updateController.add(BlocResult.errors(error.code, error.message));
        }else{
          _updateController.add(BlocResult.error(error));
        }

    });    

  }

  @override
  void dispose() {

    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _updateController.close();

  }

}