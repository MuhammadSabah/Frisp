import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/features/recipe_feed/widgets/animated_like_button.dart';
import 'package:food_recipe_final/src/features/search_recipe/widgets/custom_drop_down.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RecipePostCard extends StatefulWidget {
  const RecipePostCard({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);
  final UserModel? user;
  final RecipePostModel post;

  @override
  State<RecipePostCard> createState() => _RecipePostCardState();
}

class _RecipePostCardState extends State<RecipePostCard> {
  List<String> popUpMenuItems = ['Delete'];
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);

    UserModel? user = userProvider.getUser;
    final postProvider = Provider.of<RecipePostProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: settingsManager.darkMode ? kGreyColor2 : kGreyColor4,
          border: Border.symmetric(
            horizontal: BorderSide(
              color:
                  settingsManager.darkMode ? kBlackColor : Colors.grey.shade400,
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
                            ? Center(
                                child: LinearProgressIndicator(
                                  color: kOrangeColor,
                                  backgroundColor: settingsManager.darkMode
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                ),
                              )
                            : widget.post.profImage == ""
                                ? Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/default_image.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: widget.post.profImage,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: FaIcon(
                                          FontAwesomeIcons.circleExclamation),
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                            baseColor: Colors.grey.shade400,
                                            highlightColor:
                                                Colors.grey.shade300,
                                            child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3.3,
                                                width: double.infinity)),
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
                                GestureDetector(
                                  onTap: () {
                                    if (currentUser!.uid != widget.post.uid) {
                                      Navigator.pushNamed(
                                        context,
                                        AppPages.profilePath,
                                        arguments: widget.post.uid,
                                      );
                                    }
                                  },
                                  child: Text(
                                    widget.post.userName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.post.userEmail,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: settingsManager.darkMode
                                            ? Colors.grey
                                            : Colors.grey.shade800,
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
                  // !: PopUpMenu
                  currentUser?.uid != widget.post.uid
                      ? const SizedBox()
                      : PopupMenuButton(
                          splashRadius: 20,
                          icon: FaIcon(
                            FontAwesomeIcons.ellipsisVertical,
                            size: 18,
                            color: settingsManager.darkMode
                                ? Colors.white
                                : Colors.grey.shade300,
                          ),
                          onSelected: (String value) {
                            if (value == 'Delete') {
                              Provider.of<RecipePostProvider>(context,
                                      listen: false)
                                  .deletePost(widget.post.postId);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return popUpMenuItems
                                .map<CustomDropDownMenu<String>>(
                                  (String value) => CustomDropDownMenu(
                                    value: value,
                                    text: value,
                                    isRemovable: false,
                                    callback: () {
                                      setState(
                                        () {
                                          FocusScope.of(context).unfocus();
                                          popUpMenuItems.remove(value);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                )
                                .toList();
                          },
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
                      widget.post.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppPages.recipePostDetails,
                          arguments: widget.post,
                        );
                      },
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: Colors.grey.withOpacity(0.1),
                        child: Stack(
                          children: [
                            Container(
                              height: screenHeight / 3,
                              width: screenWidth - 24,
                              decoration: BoxDecoration(
                                color: settingsManager.darkMode
                                    ? kGreyColor
                                    : Colors.grey.shade400,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.post.postUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: FaIcon(
                                        FontAwesomeIcons.circleExclamation),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.grey.shade300,
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3.3,
                                        width: double.infinity),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      // 3.2 is the image height.
                                      height: (screenHeight / 3.2) / 4.3,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.grey.withOpacity(0.3),
                                            Colors.grey.withOpacity(0.15),
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
                                                          widget.post.title,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(),
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
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            child: widget.post.likes.length == 1
                                ? Text(
                                    '${widget.post.likes.length.toString()} Like',
                                    maxLines: 1,
                                  )
                                : Text(
                                    '${widget.post.likes.length.toString()} Likes',
                                    maxLines: 1,
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
                                  : widget.post.likes.contains(user.id),
                              child: IconButton(
                                key: const Key('likeButton'),
                                splashRadius: 20,
                                onPressed: () async {
                                  await postProvider.likeOrUnlikePost(
                                    postId: widget.post.postId,
                                    userId: user!.id,
                                    likes: widget.post.likes,
                                  );
                                },
                                icon: user == null
                                    ? Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.grey.shade300,
                                      )
                                    : widget.post.likes.contains(user.id)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            color: settingsManager.darkMode
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800,
                                          ),
                              ),
                            ),
                            IconButton(
                              key: const Key('commentButton'),
                              splashRadius: 20,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppPages.commentsPath,
                                  arguments: widget.post,
                                );
                              },
                              icon: Icon(
                                Icons.comment,
                                color: settingsManager.darkMode
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade800,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_outlined,
                                color: settingsManager.darkMode
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade900,
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
