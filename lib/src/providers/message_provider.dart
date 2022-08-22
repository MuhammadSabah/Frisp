import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:uuid/uuid.dart';

class MessageProvider extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference? chatCollection;

  Future<void> createUserContactsCollection({
    required UserModel user,
    required UserModel currentUser,
  }) async {
    try {
      CollectionReference userContactsCollection =
          _firestore.collection('users').doc(user.id).collection('contacts');
      //

      final userContactsList = _firestore
          .collection('users')
          .doc(user.id)
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
          .doc(user.id);

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

      //********************************************* */
      CollectionReference messagesCollection =
          _firestore.collection('messages');
      //
      String messageId = const Uuid().v1();
      chatCollection = _firestore
          .collection('messages')
          .doc(messageId)
          .collection('chatMessages');
      //
      messagesCollection.doc(messageId).set({
        'currentUserId': currentUser.id,
        'oppositeUserId': user.id,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage(
      Message message, String oppositeUserId, String currentUserId) {
    chatCollection!.add(message.toJson());
  }
}
