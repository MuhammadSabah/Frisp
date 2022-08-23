import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:uuid/uuid.dart';

class MessageProvider extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserContactsCollection({
    required UserModel user,
    required UserModel currentUser,
  }) async {
    try {
      String userEmail = user.email;
      String currentUserEmail = currentUser.email;
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

      //
      // String messageId = const Uuid().v1();
      // //
      // final messagesDocuments = messagesCollection.doc(messageId);
      // messagesDocuments.get().then(
      //       (snapshot) => {
      //         if (!snapshot.exists)
      //           {
      //             messagesCollection.doc(messageId).set({
      //               userEmail: true,
      //               currentUserEmail: true,
      //             }),
      //           }
      //       },
      //     );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage(
      Message message, String oppositeUserId, String currentUserId) async {
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('contacts')
        .doc(oppositeUserId)
        .collection('messages')
        .add(message.toJson());
    //
    await _firestore
        .collection('users')
        .doc(oppositeUserId)
        .collection('contacts')
        .doc(currentUserId)
        .collection('messages')
        .add(message.toJson());
  }
}
