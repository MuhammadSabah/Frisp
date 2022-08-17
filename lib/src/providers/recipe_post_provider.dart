import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:uuid/uuid.dart';

class RecipePostProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _recipePostLength = 0;
  // late bool _isFollowing;

  int get getRecipePostLength => _recipePostLength;
  // bool get getIsFollowing => _isFollowing;
  //
  void updateRecipePostInfo(String? userId) async {
    QuerySnapshot<Map<String, dynamic>> recipePostSnapshots =
        await FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: userId)
            .get();
    if (recipePostSnapshots.docs.isNotEmpty) {
      _recipePostLength = recipePostSnapshots.docs.length;
    }
    notifyListeners();
  }

  //
  // Future<void> checkIsFollowing(String? userId) async {
  //   UserModel? user;
  //   DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //       await _firestore.collection('users').doc(userId).get();
  //   if (userSnapshot.exists) {
  //     user = UserModel.fromSnapshot(userSnapshot);
  //   }
  //   if (user != null) {
  //     if (user.followers.contains(_auth.currentUser!.uid)) {
  //       _isFollowing = true;
  //     } else {
  //       _isFollowing = false;
  //     }
  //     notifyListeners();
  //   }
  // }

  Future<String?> uploadRecipePost({
    required String uid,
    required String userName,
    required String userEmail,
    required Uint8List imageFile,
    required String profImage,
    required String title,
    required String description,
    required String serves,
    required String cookTime,
    required List ingredients,
    required List steps,
  }) async {
    try {
      String fileImageUrl = await UserImageProvider().uploadAnImageToStorage(
        fileName: 'posts',
        file: imageFile,
        isPost: true,
      );
      String recipePostId = const Uuid().v1();
      RecipePostModel recipePost = RecipePostModel(
        uid: uid,
        postId: recipePostId,
        userName: userName,
        userEmail: userEmail,
        datePublished: DateTime.now(),
        profImage: profImage,
        postUrl: fileImageUrl,
        likes: [],
        title: title,
        description: description,
        serveAmount: serves,
        cookTime: cookTime,
        ingredients: ingredients,
        instructions: steps,
      );
      _firestore.collection('posts').doc(recipePostId).set(
            recipePost.toJson(),
          );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String recipePostId) async {
    try {
      await _firestore.collection('posts').doc(recipePostId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> postComment({
    required String userName,
    required String profileImage,
    required String postId,
    required String text,
    required String uid,
  }) async {
    try {
      String commentId = const Uuid().v1();
      final comment = CommentModel(
        userId: uid,
        userName: userName,
        commentId: commentId,
        commentText: text,
        profilePicture: profileImage,
        dateCommented: DateTime.now(),
      );
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(
            comment.toJson(),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> likePost({
    required String postId,
    required String userId,
    required List likes,
  }) async {
    try {
      if (likes.contains(userId)) {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayRemove([userId])
          },
        );
      } else {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayUnion([userId])
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> followOrUnfollowUser({
    required String userId,
    required String followId,
    required UserModel currentUser,
  }) async {
    try {
      //
      DocumentSnapshot currentUserSnapshot =
          await _firestore.collection('users').doc(userId).get();
      currentUser = UserModel.fromSnapshot(currentUserSnapshot);
      //
      DocumentSnapshot followedUserSnapshot =
          await _firestore.collection('users').doc(followId).get();
      UserModel followedUser = UserModel.fromSnapshot(followedUserSnapshot);
      //
      if (currentUser.following.contains(followId)) {
        await followedUser.reference?.update({
          'followers': FieldValue.arrayRemove([userId]),
        });
        await currentUser.reference?.update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await followedUser.reference?.update({
          'followers': FieldValue.arrayUnion([userId])
        });
        await currentUser.reference?.update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
