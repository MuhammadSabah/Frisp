import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _user;
  UserModel? get getUser => _user;

  Future<UserModel?> getUserFromDocument() async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    UserModel? userModel;
    if (userSnapshot.exists) {
      userModel = UserModel.fromSnapshot(userSnapshot);
    }

    return userModel;
  }

  Future<void> refreshUser() async {
    UserModel? user = await getUserFromDocument();
    if (user != null) {
      _user = user;
    }
    notifyListeners();
  }
}
