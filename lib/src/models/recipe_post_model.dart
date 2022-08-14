import 'package:cloud_firestore/cloud_firestore.dart';

class RecipePostModel {
  final String uid;
  final String postId;
  final String userName;
  final String userEmail;
  final DateTime datePublished;
  final String profImage;
  final String postUrl;
  final List<String> likes;
  final String title;
  final String description;
  final String serveAmount;
  final String cookTime;
  final List ingredients;
  final List instructions;
  DocumentReference? reference;

  RecipePostModel({
    this.reference,
    required this.uid,
    required this.postId,
    required this.userName,
    required this.userEmail,
    required this.datePublished,
    required this.profImage,
    required this.postUrl,
    required this.likes,
    required this.title,
    required this.description,
    required this.serveAmount,
    required this.cookTime,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'postId': postId});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});
    result.addAll({'datePublished': datePublished.millisecondsSinceEpoch});
    result.addAll({'profImage': profImage});
    result.addAll({'postUrl': postUrl});
    result.addAll({'likes': likes});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'serveAmount': serveAmount});
    result.addAll({'cookTime': cookTime});
    result.addAll({'ingredients': ingredients});
    result.addAll({'instructions': instructions});

    return result;
  }

  factory RecipePostModel.fromJson(Map<String, dynamic> json) {
    return RecipePostModel(
      uid: json['uid'] ?? '',
      postId: json['postId'] ?? '',
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(json['datePublished']),
      profImage: json['profImage'] ?? '',
      postUrl: json['postUrl'] ?? '',
      likes: List<String>.from(json['likes']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      serveAmount: json['serveAmount'] ?? '',
      cookTime: json['cookTime'] ?? '',
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
    );
  }
  factory RecipePostModel.fromSnapshot(DocumentSnapshot snapshot) {
    final recipePost =
        RecipePostModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return recipePost;
  }

  RecipePostModel copyWith({
    String? uid,
    String? postId,
    String? userName,
    String? userEmail,
    DateTime? datePublished,
    String? profImage,
    String? postUrl,
    List<String>? likes,
    String? title,
    String? description,
    String? serveAmount,
    String? cookTime,
    List<String>? ingredients,
    List<String>? instructions,
  }) {
    return RecipePostModel(
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      datePublished: datePublished ?? this.datePublished,
      profImage: profImage ?? this.profImage,
      postUrl: postUrl ?? this.postUrl,
      likes: likes ?? this.likes,
      title: title ?? this.title,
      description: description ?? this.description,
      serveAmount: serveAmount ?? this.serveAmount,
      cookTime: cookTime ?? this.cookTime,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }
}
