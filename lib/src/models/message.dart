import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipe_final/src/models/enums/message_enum.dart';

class Message {
  final bool isSeen;
  // final MessageEnum type;
  final String userId;
  final String receiverId;
  final String messageText;
  final DateTime sentAt;
  DocumentReference? reference;

  Message({
    required this.isSeen,
    // required this.type,
    required this.userId,
    required this.receiverId,
    required this.messageText,
    required this.sentAt,
    this.reference,
  });

  Message copyWith({
    bool? isSeen,
    MessageEnum? type,
    String? userId,
    String? receiverId,
    String? messageText,
    DateTime? sentAt,
    DocumentReference? reference,
  }) {
    return Message(
      isSeen: isSeen ?? this.isSeen,
      // type: type ?? this.type,
      userId: userId ?? this.userId,
      receiverId: receiverId ?? this.receiverId,
      messageText: messageText ?? this.messageText,
      sentAt: sentAt ?? this.sentAt,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'isSeen': isSeen});
    // result.addAll({'type': type.string});
    result.addAll({'userId': userId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'messageText': messageText});
    result.addAll({'sentAt': sentAt.millisecondsSinceEpoch});

    return result;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      isSeen: json['isSeen'] ?? false,
      // type: (json['type'] as String).toEnum(),
      userId: json['userId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      messageText: json['messageText'] ?? '',
      sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt']),
    );
  }

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    return message;
  }
}
