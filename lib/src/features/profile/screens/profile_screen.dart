import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/features/profile/screens/edit_profile_screen.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_back_button.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_cached_background_photo.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_default_background_photo.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_info_container.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_messages_button.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_post_section.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_send_message_button.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_settings_button.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  String? userId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isLoadingProfile = false;
  String imageUrl = 'assets/default_image.jpg';
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> getUserData() async {
  //   setState(() {
  //     _isLoadingProfile = true;
  //   });
  //   try {
  //     final recipePostProvider =
  //         Provider.of<RecipePostProvider>(context, listen: false);
  //     recipePostProvider.updateRecipePostInfo(widget.userId);

  //     setState(() {});
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   setState(() {
  //     _isLoadingProfile = false;
  //   });
  // }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      streamResult = FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: widget.userId)
          .snapshots();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingProfile
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Theme(
            data: Theme.of(context).copyWith(useMaterial3: false),
            child: RefreshIndicator(
              color: kOrangeColor,
              backgroundColor: Colors.white,
              displacement: 50,
              onRefresh: _refresh,
              child: Scaffold(
                key: const Key('ProfileScreen'),
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('id', isEqualTo: widget.userId)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LinearProgressIndicator(
                              color: kOrangeColor,
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error occurred!'),
                          );
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text('No Data!'),
                          );
                        } else {
                          UserModel user =
                              UserModel.fromSnapshot(snapshot.data.docs[0]);
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.9,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      user.photoUrl == ""
                                          ? const ProfileDefaultBackgroundPhoto()
                                          : ProfileCachedBackgroundPhoto(
                                              user: user,
                                            ),
                                      Positioned(
                                        top: 3,
                                        right: 5,
                                        child: Row(
                                          children: [
                                            FirebaseAuth.instance.currentUser!
                                                        .uid !=
                                                    widget.userId
                                                ? ProfileSendMessageButton(
                                                    user: user,
                                                  )
                                                : ProfileMessageButton(
                                                    userId: widget.userId!,
                                                  ),
                                            const ProfileSettingsButton(),
                                          ],
                                        ),
                                      ),
                                      FirebaseAuth.instance.currentUser!.uid !=
                                              widget.userId
                                          ? const ProfileBackButton()
                                          : const SizedBox(),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ProfileInfoContainer(
                                          
                                          user: user,
                                          userId: widget.userId,
                                          onEdit: () async {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen(
                                                  user: user,
                                                ),
                                              ),
                                            );
                                            // if (!mounted) return;
                                            // if (result == 'SaveData') {
                                            //   await _refresh();
                                            // }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //!: Recipe Post Section:
                                ProfilePostSection(userId: widget.userId!),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
