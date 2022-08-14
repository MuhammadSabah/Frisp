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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comment.profilePicture == ""
              ? const CircleAvatar(
                  backgroundImage: AssetImage("assets/default_image.jpg"),
                  radius: 18,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(widget.comment.profilePicture),
                  radius: 18,
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.comment.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      Text(
                        'm',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.comment.commentText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    color: Colors.grey.shade300,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.comment.dateCommented,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                      children: const [
                        TextSpan(text: ""),
                        TextSpan(text: 'Like'),
                        TextSpan(text: '  ●  '),
                        TextSpan(text: 'Reply'),
                        TextSpan(text: '  ●  '),
                        TextSpan(text: 'Report'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
