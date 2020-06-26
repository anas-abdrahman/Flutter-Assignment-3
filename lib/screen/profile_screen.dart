import 'dart:io';
import 'dart:ui';

import 'package:assignment_3/bloc/update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:assignment_3/utils/app_camera.dart';

import '../bloc/bloc_result.dart';
import '../firebase/auth.dart';
import '../model/user.dart';
import '../utils/app_dialog.dart';
import '../widget/app_loader.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdateBloc _updateBloc = UpdateBloc();
  bool _showLoading = true;
  bool profileUpdated = false;

  ImageProvider imageProfile;
  String imageUrl;

  @override
  void initState() {
    Auth.getCurrentUser().then((auth) async {
      final data = await Auth.getUserFirestore(auth.uid);

      setState(() {
        user = data;
        _showLoading = false;
        _nameController.text = data.name;
        _phoneController.text = data.phone;
        _emailController.text = data.email;

        if(data.image != null) imageProfile = NetworkImage(data.image);
        
      });
    });

    _updateBloc.updateStream.listen((blocResult) {
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
            'Update Successfully',
            () => Navigator.pop(context),
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
    final screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Material App',
      home: SafeArea(
        child: Scaffold(
          body: AppLoader(
            showLoading: _showLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF2ab269),
                              Color(0xFF2fba9d),
                            ],
                          ),
                        ),
                        height: screenSize.height * 0.3,
                        width: screenSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: imageProfile ??
                                        AssetImage(
                                            'assets/images/profile_image.png'),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppCamera(),
                                  ),
                                ).then(
                                  (imagePath) {
                                    if (imagePath != null) {
                                      final imageFile = File(imagePath);

                                      Auth.uploadProfile(imageFile).then((value) => imageUrl = value);
                                      profileUpdated = true;

                                      setState(() {
                                        imageProfile = FileImage(imageFile);
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                            InkWell(
                              child: Text(
                                'Edit Photo',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppCamera(),
                                  ),
                                ).then(
                                  (imagePath) {
                                    if (imagePath != null) {

                                      final imageFile = File(imagePath);

                                      Auth.uploadProfile(imageFile).then((value) => imageUrl = value);
                                      profileUpdated = true;

                                      setState(() {
                                        imageProfile = FileImage(imageFile);
                                      });

                                    }
                                  },
                                );
                              },
                            ),
                            Text(
                              'My Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Full Name'),
                          TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocus,
                          ),
                          SizedBox(height: 30),
                          Text('Phone Number'),
                          TextFormField(
                            controller: _phoneController,
                            focusNode: _phoneFocus,
                          ),
                          SizedBox(height: 30),
                          Text('Email Address'),
                          TextFormField(
                            controller: _emailController,
                            enabled: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: null,
                                    child: Text(
                                      'Get Location',
                                      style: TextStyle(color: Colors.blue[500]),
                                    ),
                                  ),
                                  Text('LN 19.2011564 LT 20.35489')
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.grey[500],
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FlatButton(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF2AB57D),
                                  onPressed: () {
                                    _nameFocus.unfocus();
                                    _emailFocus.unfocus();
                                    _phoneFocus.unfocus();

                                    final FormState form =
                                        _formKey.currentState;

                                    if (form.validate()) {
                                      final name = _nameController.text;
                                      final email = _emailController.text;
                                      final phone = _phoneController.text;

                                      _updateBloc.update(
                                        user: User(
                                          id: user.id,
                                          name: name,
                                          email: email,
                                          phone: phone,
                                          image: profileUpdated ?  imageUrl : user.image
                                        ),
                                      );

                                      print(name);
                                    } else {
                                      print('no valid');
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
