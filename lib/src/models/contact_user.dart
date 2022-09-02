import 'package:cloud_firestore/cloud_firestore.dart';

class ContactUser {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
  ContactUser({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  ContactUser copyWith({
    String? name,
    String? profilePic,
    String? contactId,
    DateTime? timeSent,
    String? lastMessage,
  }) {
    return ContactUser(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      contactId: contactId ?? this.contactId,
      timeSent: timeSent ?? this.timeSent,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'profilePic': profilePic});
    result.addAll({'contactId': contactId});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'lastMessage': lastMessage});

    return result;
  }

  factory ContactUser.fromJson(Map<String, dynamic> map) {
    return ContactUser(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  factory ContactUser.fromSnapshot(DocumentSnapshot snapshot) {
    final contactUser =
        ContactUser.fromJson(snapshot.data() as Map<String, dynamic>);
    return contactUser;
  }
}
