import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ProfileInfoContainer extends StatefulWidget {
  const ProfileInfoContainer({
    Key? key,
    required this.user,
    required this.userId,
    required this.onEdit,
  }) : super(key: key);
  final UserModel user;
  final String? userId;
  final Function()? onEdit;

  @override
  State<ProfileInfoContainer> createState() => _ProfileInfoContainerState();
}

class _ProfileInfoContainerState extends State<ProfileInfoContainer> {
  bool _isFollowing = false;
  bool _isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? recipeLengthResult;
  Future<void> checkFollowingState(String? userId) async {
    setState(() {
      _isLoading = true;
    });
    UserModel? user;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      user = UserModel.fromSnapshot(userSnapshot);
    }
    if (user != null) {
      if (user.followers.contains(_auth.currentUser!.uid)) {
        _isFollowing = true;
      } else {
        _isFollowing = false;
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    checkFollowingState(widget.userId);
    recipeLengthResult = _firestore
        .collection('posts')
        .where('uid', isEqualTo: widget.userId)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipePostProvider =
        Provider.of<RecipePostProvider>(context, listen: true);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.2,
            decoration: BoxDecoration(
              color: settingsManager.darkMode
                  ? kGreyColor
                  : const Color.fromRGBO(218, 218, 218, 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0)
                              .copyWith(top: 6),
                          child: Text(
                            widget.user.userName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  child: Text(
                                    widget.user.bio,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: settingsManager.darkMode
                                              ? Colors.grey
                                              : Colors.grey.shade800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FirebaseAuth.instance.currentUser!.uid == widget.userId
                            ? Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: GestureDetector(
                                  key: const Key('editProfileButton'),
                                  onTap: widget.onEdit,
                                  child: Container(
                                    width: 130,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: settingsManager.darkMode
                                          ? Colors.white
                                          : Colors.grey.shade900,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Edit Profile',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: settingsManager.darkMode
                                                    ? kGreyColor
                                                    : Colors.white,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : _isFollowing == false &&
                                    FirebaseAuth.instance.currentUser!.uid !=
                                        widget.userId
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await recipePostProvider
                                            .followOrUnfollowUser(
                                          userId: _auth.currentUser!.uid,
                                          followId: widget.userId!,
                                          currentUser: widget.user,
                                        );
                                        setState(() {
                                          _isFollowing = true;
                                        });
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 36,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        child: Center(
                                          child: _isLoading
                                              ? const SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : Text(
                                                  "Follow",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: kGreyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await recipePostProvider
                                            .followOrUnfollowUser(
                                          userId: _auth.currentUser!.uid,
                                          followId: widget.userId!,
                                          currentUser: widget.user,
                                        );
                                        setState(() {
                                          _isFollowing = false;
                                        });
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 36,
                                        decoration: const BoxDecoration(
                                          color: kOrangeColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        child: Center(
                                          child: _isLoading
                                              ? const SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: kOrangeColor,
                                                  ),
                                                )
                                              : Text(
                                                  "Unfollow",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Recipes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: settingsManager.darkMode
                                                ? Colors.grey
                                                : Colors.grey.shade800,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                    stream: recipeLengthResult,
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CupertinoActivityIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                          child: Text('⚠️'),
                                        );
                                      } else if (snapshot.data == null) {
                                        return const Center(
                                          child: Text('0'),
                                        );
                                      } else {
                                        return Text(snapshot.data.docs.length
                                            .toString());
                                      }
                                    },
                                  ),
                                ],
                              ),
                              GestureDetector(
                                // behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPages.followersPath,
                                    arguments: widget.user,
                                  );
                                },
                                child: AbsorbPointer(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Followers',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: settingsManager.darkMode
                                                    ? Colors.grey
                                                    : Colors.grey.shade800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Text(widget.user.followers.length
                                          .toString()),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPages.followingPath,
                                    arguments: widget.user,
                                  );
                                },
                                child: AbsorbPointer(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Following',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: settingsManager.darkMode
                                                    ? Colors.grey
                                                    : Colors.grey.shade800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Text(widget.user.following.length
                                          .toString()),
                                    ],
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}
