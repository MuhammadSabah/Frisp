import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:food_recipe_final/src/models/reply_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {Key? key,
      required this.reply,
      required this.comment,
      required this.postId})
      : super(key: key);
  final ReplyModel reply;
  final CommentModel comment;
  final String postId;
  String daysBetween(DateTime commentedDate) {
    String date;
    if ((DateTime.now().difference(reply.dateCommented).inHours / 24).round() ==
        1) {
      date = DateFormat('kk:mm').format(
        reply.dateCommented,
      );
      return 'Yesterday at $date';
    }
    if ((DateTime.now().difference(reply.dateCommented).inHours / 24).round() >
        1) {
      date = DateFormat('dd MMMM, kk:mm').format(
        reply.dateCommented,
      );
      return date;
    } else {
      date = DateFormat('kk:mm').format(
        reply.dateCommented,
      );
      return 'Today at $date';
    }
  }

  String likeOrUnlikeText() {
    if (reply.likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
      return "Unlike";
    }
    return 'Like';
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<RecipePostProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reply.profilePicture == ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Image.asset(
                      'assets/default_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: CachedNetworkImage(
                      imageUrl: reply.profilePicture,
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
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          reply.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 13,
                                  ),
                        ),
                      ),
                      Text(
                        daysBetween(reply.dateCommented),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 10,
                              color: settingsManager.darkMode
                                  ? Colors.grey
                                  : Colors.grey.shade800,
                            ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                reply.replyText,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 13,
                                      color: settingsManager.darkMode
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade800,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 13,
                            color: settingsManager.darkMode
                                ? Colors.grey
                                : Colors.grey.shade600,
                          ),
                      children: [
                        TextSpan(
                          text: '${reply.likes.length} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: settingsManager.darkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: likeOrUnlikeText(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              commentProvider.likeOrUnlikeRepliedComment(
                                postId: postId,
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                commentId: comment.commentId,
                                replyId: reply.replyId,
                                likes: reply.likes,
                              );
                            },
                        ),
                        const TextSpan(text: '  ●  '),
                        const TextSpan(text: 'Report'),
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
