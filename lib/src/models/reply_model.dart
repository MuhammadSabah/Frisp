import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyModel {
  final String userId;
  final String userName;
  final String replyId;
  final String replyText;
  final String profilePicture;
  final List likes;
  final DateTime dateCommented;
  ReplyModel({
    required this.userId,
    required this.userName,
    required this.replyId,
    required this.replyText,
    required this.profilePicture,
    required this.likes,
    required this.dateCommented,
  });

  ReplyModel copyWith({
    String? userId,
    String? userName,
    String? replyId,
    String? replyText,
    String? profilePicture,
    List? likes,
    DateTime? dateCommented,
  }) {
    return ReplyModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      replyId: replyId ?? this.replyId,
      replyText: replyText ?? this.replyText,
      profilePicture: profilePicture ?? this.profilePicture,
      likes: likes ?? this.likes,
      dateCommented: dateCommented ?? this.dateCommented,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'userName': userName});
    result.addAll({'replyId': replyId});
    result.addAll({'replyText': replyText});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'likes': likes});
    result.addAll({'dateCommented': dateCommented.millisecondsSinceEpoch});

    return result;
  }

  factory ReplyModel.fromJson(Map<String, dynamic> map) {
    return ReplyModel(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      replyId: map['replyId'] ?? '',
      replyText: map['replyText'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      likes: List.from(map['likes']),
      dateCommented: DateTime.fromMillisecondsSinceEpoch(map['dateCommented']),
    );
  }
    factory ReplyModel.fromSnapshot(DocumentSnapshot snapshot) {
    final ReplyModel comment =
        ReplyModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return comment;
  }
}
