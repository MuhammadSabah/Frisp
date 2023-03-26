import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

// test case for getUserFromDocument returns user model when user logged in 

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserProvider(this._firestore, this._auth);

  UserModel? _user;
  UserModel? get getUser => _user;
  String? _userAuthId;
  String? get getUserAuthId => _userAuthId;
  Future<void> setUserAuthId() async {
    _userAuthId = _auth.currentUser!.uid;
    notifyListeners();
  }

  // Getting the user from firestore and creating a model for it if exists.
  Future<UserModel?> getUserFromDocument() async {
    UserModel? userModel;
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (userSnapshot.exists) {
        userModel = UserModel.fromSnapshot(userSnapshot);
      } else {
        return null;
      }
    }
    return userModel;
  }

  Future<void> refreshUser() async {
    UserModel? user = await getUserFromDocument();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
