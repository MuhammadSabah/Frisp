import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class MessageProvider extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserContactsCollection({
    required String uid,
    required UserModel user,
  }) async {
    try {
      CollectionReference userContactsCollection =
          _firestore.collection('users').doc(uid).collection('contacts');
      //

      final userContactsList = _firestore
          .collection('users')
          .doc(uid)
          .collection('contacts')
          .doc(uid);

      userContactsList.get().then(
            (snapshot) => {
              if (!snapshot.exists)
                {
                  userContactsCollection.doc(user.id).set(
                        user.toJson(),
                      ),
                }
            },
          );

      //!:*********************************
      CollectionReference currentUserContactsCollection = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contacts');
      //

      final currentUserContactsList = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contacts')
          .doc(_auth.currentUser!.uid);

      currentUserContactsList.get().then(
            (snapshot) => {
              if (!snapshot.exists)
                {
                  currentUserContactsCollection.doc(user.id).set(
                        user.toJson(),
                      ),
                }
            },
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage(Message message, String userId) {
    _firestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .add(message.toJson());
  }
}
