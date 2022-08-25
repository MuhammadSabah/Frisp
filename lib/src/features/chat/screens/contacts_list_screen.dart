import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        Provider.of<SettingsManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kOrangeColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.more_horiz,
              color: kOrangeColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('contacts')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null || !snapshot.hasData) {
            return const Center(
              child: Text("You don't have any contact"),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred!'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("You don't have any contact"),
            );
          }
          final contactUsersList = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: contactUsersList.length,
              itemBuilder: (context, index) {
                final contactUser =
                    UserModel.fromSnapshot(contactUsersList[index]);
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppPages.chatPath,
                          arguments: contactUser,
                        );
                     
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: ListTile(
                          title: Text(
                            contactUser.userName,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Last message',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: contactUser.photoUrl == ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/default_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: contactUser.photoUrl,
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
                          trailing: const Text(
                            '21:09',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade800,
                      thickness: 1.1,
                      indent: 80,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
