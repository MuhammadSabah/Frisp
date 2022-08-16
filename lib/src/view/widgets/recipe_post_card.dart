import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/screens/comments_screen/comments_screen.dart';
import 'package:food_recipe_final/src/view/widgets/animated_like_button.dart';
import 'package:provider/provider.dart';

class RecipePostCard extends StatelessWidget {
  const RecipePostCard({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);
  final UserModel? user;
  final RecipePostModel post;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    Provider.of<UserProvider>(context, listen: false).refreshUser();
    UserModel? user = userProvider.getUser;
    final postProvider = Provider.of<RecipePostProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: const BoxDecoration(
          color: kGreyColor2,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: kBlackColor,
              width: 3,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User image and user name section.
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth - (screenWidth - 15),
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 8,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: user == null
                            ? const Center(
                                child: LinearProgressIndicator(
                                  color: kOrangeColor,
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : post.profImage == ""
                                ? Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/default_image.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(post.profImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  post.userName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  post.userEmail,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
            //The post description.
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      post.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            //Image container or card.
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.grey.withOpacity(0.1),
                      child: Stack(
                        children: [
                          Container(
                            height: screenHeight / 3,
                            width: screenWidth - 24,
                            decoration: const BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(post.postUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              // 3.2 is the image height.
                              height: (screenHeight / 3.2) / 4.1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.white.withOpacity(0.5),
                                    Colors.white.withOpacity(0.2),
                                  ],
                                  stops: const [0.0, 1.0],
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                // border:
                                //     Border.all(width: 2, color: Colors.white30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  post.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color: kBlackColor,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       child: Text(
                                          //         'Subtitle',
                                          //         overflow:
                                          //             TextOverflow.ellipsis,
                                          //         maxLines: 1,
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .headline3!
                                          //             .copyWith(
                                          //                 color: Colors
                                          //                     .grey.shade600),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Likes and other interactions:
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${post.likes.length.toString()} Likes',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0)
                            .copyWith(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //!: Like button:
                            AnimatedLikeButton(
                              isAnimating: user == null
                                  ? false
                                  : post.likes.contains(user.id),
                              child: IconButton(
                                splashRadius: 20,
                                onPressed: () async {
                                  await postProvider.likePost(
                                    postId: post.postId,
                                    userId: user!.id,
                                    likes: post.likes,
                                  );
                                },
                                icon: user == null
                                    ? Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.grey.shade300,
                                      )
                                    : post.likes.contains(user.id)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.grey.shade300,
                                          ),
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                            recipePost: post,
                                          )),
                                );
                              },
                              icon: Icon(
                                Icons.comment,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_outlined,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
