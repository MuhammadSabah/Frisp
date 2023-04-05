import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class UserSearchResultList extends StatelessWidget {
  UserSearchResultList({
    Key? key,
    required this.searchName,
    required this.snapshot,
  }) : super(key: key);
  String searchName;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    searchName = searchName.toLowerCase();
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchName.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Text('Suggestions'),
              )
            : const SizedBox(),
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              UserModel user = UserModel.fromSnapshot(
                snapshot.data.docs[index],
              );
              if (user.id == FirebaseAuth.instance.currentUser!.uid) {
                return const SizedBox();
              }
              if (user.userName.isEmpty) {
                return InkWell(
                  key: const Key('userSearchResultList'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppPages.profilePath,
                      arguments: user.id,
                    );
                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: user.photoUrl == ""
                            ? Image.asset(
                                'assets/default_image.jpg',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: user.photoUrl,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.3,
                                            width: double.infinity)),
                              ),
                      ),
                    ),
                    title: Text(
                      user.userName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    subtitle: Text(
                      user.email,
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

              if (user.userName
                  .toString()
                  .toLowerCase()
                  .startsWith(searchName.toLowerCase())) {
                return InkWell(
                  key: const Key('userSearchResultList'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppPages.profilePath,
                      arguments: user.id,
                    );
                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: user.photoUrl == ""
                            ? Image.asset(
                                'assets/default_image.jpg',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: user.photoUrl,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.3,
                                            width: double.infinity)),
                              ),
                      ),
                    ),
                    title: Text(
                      user.userName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    subtitle: Text(
                      user.email,
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
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
