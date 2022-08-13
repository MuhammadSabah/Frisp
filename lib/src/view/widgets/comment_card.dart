import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final CommentModel comment;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.comment.profilePicture),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.comment.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  ${widget.comment.commentText}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.comment.dateCommented,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.favorite,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
