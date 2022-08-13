import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:uuid/uuid.dart';

class RecipePostProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> likePost(
      {required String postId,
      required String userId,
      required List<dynamic> likes}) async {
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
}
