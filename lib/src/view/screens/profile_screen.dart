import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/view/widgets/profile_back_button.dart';
import 'package:food_recipe_final/src/view/widgets/profile_cached_background_photo.dart';
import 'package:food_recipe_final/src/view/widgets/profile_default_background_photo.dart';
import 'package:food_recipe_final/src/view/widgets/profile_info_container.dart';
import 'package:food_recipe_final/src/view/widgets/profile_post_section.dart';
import 'package:food_recipe_final/src/view/widgets/profile_settings_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.userId}) : super(key: key);
  String? userId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  bool _isLoadingProfile = false;
  String imageUrl = 'assets/default_image.jpg';
  Future<DocumentSnapshot<Map<String, dynamic>>>? futureResult;

  //
  void selectAnImage(BuildContext context) async {
    final imageProvider =
        Provider.of<UserImageProvider>(context, listen: false);

    setState(() {
      _isLoadingProfile = true;
    });

    final result = await imageProvider.pickAnImage(ImageSource.gallery);

    result.fold((l) async {
      setState(() {
        _image = l;
      });
      String downloadUrl = await imageProvider.uploadAnImageToStorage(
          fileName: 'profilePictures', file: _image!, isPost: false);
      await imageProvider.updateUserProfilePhoto(downloadUrl);
      setState(() {
        _isLoadingProfile = false;
      });
    }, (r) {
      setState(() {
        _isLoadingProfile = false;
      });
    });
  }

  //
  @override
  void initState() {
    super.initState();
    futureResult =
        FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    getUserData();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoadingProfile = true;
    });
    try {
      final recipePostProvider =
          Provider.of<RecipePostProvider>(context, listen: false);
      recipePostProvider.updateRecipePostInfo(widget.userId);

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _isLoadingProfile = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      futureResult = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      getUserData();
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
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: futureResult,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
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
                              UserModel.fromSnapshot(snapshot.data);
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Stack(
                                    children: [
                                      user.photoUrl == ""
                                          ? const ProfileDefaultBackgroundPhoto()
                                          : ProfileCachedBackgroundPhoto(
                                              user: user,
                                            ),
                                      const Positioned(
                                        top: 3,
                                        right: 5,
                                        child: ProfileSettingsButton(),
                                      ),
                                      FirebaseAuth.instance.currentUser!.uid !=
                                              widget.userId
                                          ? const Positioned(
                                              top: 3,
                                              left: 5,
                                              child: ProfileBackButton(),
                                            )
                                          : const SizedBox(),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ProfileInfoContainer(
                                          user: user,
                                          userId: widget.userId,
                                          onEdit: () {
                                            selectAnImage(context);
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
