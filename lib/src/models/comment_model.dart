import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String userId;
  final String userName;
  final String commentId;
  final String commentText;
  final String profilePicture;
  final List likes;
  final DateTime dateCommented;
  CommentModel({
    required this.userId,
    required this.userName,
    required this.commentId,
    required this.commentText,
    required this.profilePicture,
    required this.likes,
    required this.dateCommented,
  });

  CommentModel copyWith({
    String? userId,
    String? userName,
    String? commentId,
    String? commentText,
    String? profilePicture,
    DateTime? dateCommented,
  }) {
    return CommentModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      commentId: commentId ?? this.commentId,
      commentText: commentText ?? this.commentText,
      profilePicture: profilePicture ?? this.profilePicture,
      likes: likes,
      dateCommented: dateCommented ?? this.dateCommented,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'userName': userName});
    result.addAll({'commentId': commentId});
    result.addAll({'commentText': commentText});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'likes': likes});
    result.addAll({'dateCommented': dateCommented.millisecondsSinceEpoch});

    return result;
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      commentId: json['commentId'] ?? '',
      commentText: json['commentText'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      likes: json['likes'] ?? [],
      dateCommented: DateTime.fromMillisecondsSinceEpoch(json['dateCommented']),
    );
  }

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    final CommentModel comment =
        CommentModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return comment;
  }
}
