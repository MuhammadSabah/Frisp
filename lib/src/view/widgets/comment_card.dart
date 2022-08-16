import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 18,
                    child: Image.asset(
                      'assets/default_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 18,
                    child: CachedNetworkImage(
                      imageUrl: widget.comment.profilePicture,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Center(
                        child: FaIcon(FontAwesomeIcons.circleExclamation),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3.3,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
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
