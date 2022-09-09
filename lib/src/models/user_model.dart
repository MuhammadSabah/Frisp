import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;
  final String bio;
  final String lastMessage;
  final DateTime? messageSent;
  final List followers;
  final List following;
  DocumentReference? reference;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.photoUrl,
    required this.bio,
    this.lastMessage = '',
    this.messageSent,
    required this.followers,
    required this.following,
    this.reference,
  });
  UserModel copyWith({
    String? id,
    String? userName,
    String? email,
    String? photoUrl,
    String? bio,
    String? lastMessage,
    DateTime? messageSent,
    List? followers,
    List? following,
    DocumentReference? reference,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      lastMessage: lastMessage ?? this.lastMessage,
      messageSent: messageSent ?? this.messageSent,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userName': userName});
    result.addAll({'email': email});
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'bio': bio});
    result.addAll({'lastMessage': lastMessage});
    if (messageSent != null) {
      result.addAll({'messageSent': messageSent!.millisecondsSinceEpoch});
    }
    result.addAll({'followers': followers});
    result.addAll({'following': following});

    return result;
  }

  factory UserModel.fromJson(
      Map<String, dynamic> json, DocumentReference? reference) {
    return UserModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      bio: json['bio'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      messageSent: json['messageSent'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json['messageSent'].millisecondsSinceEpoch)
          : null,
      followers: json['followers'] ?? [],
      following: json['following'] ?? [],
      reference: reference,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final userModel = UserModel.fromJson(
        snapshot.data() as Map<String, dynamic>, snapshot.reference);
    return userModel;
  }
}
