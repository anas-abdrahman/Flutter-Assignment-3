import 'dart:io';

import 'package:assignment_3/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as Path;

class Auth {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  static Future<String> signIn(User user, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email, password: password);
    FirebaseUser firebaseUser = result.user;
    return firebaseUser.uid;
  }

  static Future<String> signUp(User user, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: password);
    FirebaseUser firebaseUser = result.user;
    user.id = firebaseUser.uid;
    setUserFirestore(user);
    return firebaseUser.uid;
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _firebaseAuth.signOut();
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;

    try {
      await Firestore.instance.document("users/$userId").get().then((doc) {
        if (doc.exists) {
          exists = true;
        } else {
          exists = false;
        }
      });

      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setUserFirestore(User user) async {
    if (user != null) {
      Firestore.instance.document("users/${user.id}").setData(user.toJson());
      return await Future.delayed(Duration(seconds: 1));
    } else {
      return null;
    }
  }

  static Future<User> getUserFirestore(String userId) async {
    if (userId != null) {
      return Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => User.fromDocument(documentSnapshot));
    } else {
      return null;
    }
  }

  static Future<String> uploadProfile(File image) async {

    final auth = await getCurrentUser();
    final user = await getUserFirestore(auth.uid);

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('image/${user.id}/${Path.basename(image.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.onComplete;

    final fileUrl = await storageReference.getDownloadURL();

    if(fileUrl != null) user.image = fileUrl;

    setUserFirestore(user);

    return fileUrl;
  }
}
