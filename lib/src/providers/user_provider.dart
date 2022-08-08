import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;
  UserModel? get getUser => _user;

  // Future<UserModel?> getUserFromDocument() async {
  //   User currentUser = _auth.currentUser!;
  //   var userDoc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser.uid)
  //       .get();
  //   UserModel? userModel = UserModel.fromSnapshot(userDoc);

  //   return userModel;
  // }

  // Future<void> refreshUser() async {
  //   UserModel? user = await getUserFromDocument();
  //   _user = user;
  //   notifyListeners();
  // }
}
