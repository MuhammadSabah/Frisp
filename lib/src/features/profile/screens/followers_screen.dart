import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/features/profile/screens/profile_screen.dart';
import 'package:food_recipe_final/src/features/settings/widgets/settings_back_button.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: SettingsBackButton(
          darkState: settingsManager,
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Followers',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
        ),
      ),
      body: user.followers.isEmpty
          ? const SizedBox()
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('id', whereIn: user.followers)
                  .snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: user.followers.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    UserModel followedUser = UserModel.fromSnapshot(
                      snapshot.data!.docs[index],
                    );
                    debugPrint(followedUser.userName);
                    if (followedUser.id ==
                        FirebaseAuth.instance.currentUser!.uid) {
                      return const SizedBox();
                    }
                    if (followedUser.userName.isEmpty) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPages.profilePath,
                            arguments: followedUser.id,
                          );
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: followedUser.photoUrl == ""
                                  ? Image.asset(
                                      'assets/default_image.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: followedUser.photoUrl,
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
                          title: Text(
                            followedUser.userName,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          subtitle: Text(
                            followedUser.email,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: settingsManager.darkMode
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade700),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: settingsManager.darkMode
                                  ? Colors.white
                                  : Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      );
                    }

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              userId: followedUser.id,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: followedUser.photoUrl == ""
                                ? Image.asset(
                                    'assets/default_image.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: followedUser.photoUrl,
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
                        title: Text(
                          followedUser.userName,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        subtitle: Text(
                          followedUser.email,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: settingsManager.darkMode
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade700),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: settingsManager.darkMode
                                ? Colors.white
                                : Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
    );
  }
}
