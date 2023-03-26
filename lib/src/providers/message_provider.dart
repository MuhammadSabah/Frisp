import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class MessageProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  MessageProvider(this._firestore, this._auth);

  Future<void> createUserChatCollection({
    required UserModel receiverUser,
    required UserModel currentUser,
  }) async {
    try {
      CollectionReference userContactsCollection = _firestore
          .collection('users')
          .doc(receiverUser.id)
          .collection('contacts');
      //

      final userContactsList = _firestore
          .collection('users')
          .doc(receiverUser.id)
          .collection('contacts')
          .doc(_auth.currentUser!.uid);

      userContactsList.get().then(
            (snapshot) => {
              if (!snapshot.exists)
                {
                  userContactsCollection.doc(_auth.currentUser!.uid).set(
                        currentUser.toJson(),
                      ),
                }
            },
          );

      // !:*********************************************

      CollectionReference currentUserContactsCollection = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contacts');
      //

      final currentUserContactsList = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('contacts')
          .doc(receiverUser.id);

      currentUserContactsList.get().then(
            (snapshot) => {
              if (!snapshot.exists)
                {
                  currentUserContactsCollection.doc(receiverUser.id).set(
                        receiverUser.toJson(),
                      ),
                }
            },
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // When the message is send, it will be saved in both the current user collection and the receiver user collection.
  void sendMessage(
      Message message, String oppositeUserId, String currentUserId) async {
    //
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('contacts')
        .doc(oppositeUserId)
        .collection('messages')
        .add(message.toJson());
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('contacts')
        .doc(oppositeUserId)
        .update({
      'lastMessage': message.messageText,
      'messageSent': DateTime.now()
    });
    ////////////////////////////
    await _firestore
        .collection('users')
        .doc(oppositeUserId)
        .collection('contacts')
        .doc(currentUserId)
        .update({
      'lastMessage': message.messageText,
      'messageSent': DateTime.now()
    });
    await _firestore
        .collection('users')
        .doc(oppositeUserId)
        .collection('contacts')
        .doc(currentUserId)
        .collection('messages')
        .add(message.toJson());
  }
}
