import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String userId;
  final String messageText;
  final DateTime sentAt;
  DocumentReference? reference;

  Message({
    required this.userId,
    required this.messageText,
    required this.sentAt,
    this.reference,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'messageText': messageText,
        'sentAt': sentAt.toString(),
      };

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['userId'] ?? "",
      messageText: json['messageText'] ?? "",
      sentAt: DateTime.parse(json['sentAt'] as String),
    );
  }
  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    return message;
  }
}
