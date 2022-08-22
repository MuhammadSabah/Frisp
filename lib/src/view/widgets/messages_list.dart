import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/view/widgets/my_message_bubble.dart';
import 'package:food_recipe_final/src/view/widgets/sender_message_bubble.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({
    Key? key,
    required this.messagesSnapshots,
    required this.scrollController,
  }) : super(key: key);
  final Stream<QuerySnapshot<Map<String, dynamic>>> messagesSnapshots;
  final ScrollController scrollController;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  void _scrollToBottom() {
    if (widget.scrollController.hasClients) {
      widget.scrollController
          .jumpTo(widget.scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: widget.messagesSnapshots,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null || !snapshot.hasData) {
          return const Center(
            child: Text('No data!'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred!'),
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 6),
          controller: widget.scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final message = Message.fromSnapshot(snapshot.data!.docs[index]);

            if (message.userId == FirebaseAuth.instance.currentUser!.uid) {
              return MyMessageBubble(
                message: message.messageText,
                date: message.sentAt,
              );
            } else {
              return SenderMessageBubble(
                message: message.messageText,
                date: message.sentAt,
              );
            }
          },
        );
      },
    );
  }
}
