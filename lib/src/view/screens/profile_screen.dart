import 'dart:async';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/view/widgets/profile_post_section.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  bool _isLoading = false;
  String imageUrl = 'assets/default_image.jpg';
  List<String> dropDownList = ['Settings', 'Edit Profile'];

  void selectAnImage(BuildContext context) async {
    final imageProvider =
        Provider.of<UserImageProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
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
        _isLoading = false;
      });
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(r.toString()),
          duration: const Duration(
            milliseconds: 2300,
          ),
          backgroundColor: Colors.grey.shade700,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }
  // @override
  // void afterFirstLayout(BuildContext context) {
  //   getUserData();
  // }

  // void getUserData() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   await userProvider.refreshUser();
  //   setState(() {});
  // }
  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 2300), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // UserModel? user = userProvider.getUser;

    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: RefreshIndicator(
        color: kOrangeColor,
        backgroundColor: Colors.white,
        displacement: 40,
        onRefresh: _refresh,
        child: SafeArea(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error occurred!'),
                );
              } else {
                final user = UserModel.fromSnapshot(snapshot.data);
                // debugPrint('USER: $user');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Stack(
                          children: [
                            user.photoUrl == ""
                                ? Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.3,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/default_image.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        3.3,
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: user.photoUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.3,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                            Positioned(
                                top: 0,
                                right: 5,
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<AppStateManager>(context,
                                            listen: false)
                                        .settingsClicked(true);
                                  },
                                  splashRadius: 20,
                                  icon: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.9),
                                    child: const FaIcon(
                                      FontAwesomeIcons.gear,
                                      color: kGreyColor,
                                      size: 20,
                                    ),
                                  ),
                                )),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.2,
                                  decoration: const BoxDecoration(
                                    color: kGreyColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(user.userName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 10),
                                          child: Text(
                                            'Delightful homemade tasty healthy recipes for your family',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                        FirebaseAuth.instance.currentUser!
                                                    .uid ==
                                                widget.userId
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    selectAnImage(context);
                                                  },
                                                  child: Container(
                                                    width: 130,
                                                    height: 36,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      'Edit Profile',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                              color: kGreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 110,
                                                    height: 36,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(50),
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      'Follow',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                              color: kGreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Recipes',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  const Text('128'),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Followers',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  Text(user.followers.length
                                                      .toString()),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Following',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  Text(user.following.length
                                                      .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //!: Recipe Post Section:
                      const ProfilePostSection(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
