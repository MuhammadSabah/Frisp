import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/view/screens/profile_screen.dart';
import 'package:shimmer/shimmer.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _searchUserController = TextEditingController();
  bool _showUser = false;
  Future<QuerySnapshot<Map<String, dynamic>>>? futureResult;
  @override
  void initState() {
    super.initState();
    futureResult = FirebaseFirestore.instance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: _searchUserController.text)
        .get();
  }

  void updateSearchResult() async {
    futureResult = FirebaseFirestore.instance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: _searchUserController.text)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 256;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Search User',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
          ),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                            controller: _searchUserController,
                            cursorColor: Colors.white,
                            autofocus: false,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              fillColor: kGreyColor,
                              filled: true,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(18),
                              hintText: 'Search...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                              focusedErrorBorder: kFocusedErrorBorder,
                              errorBorder: kErrorBorder,
                              enabledBorder: kEnabledBorder,
                              focusedBorder: kFocusedBorder,
                              border: kBorder,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            if (_searchUserController.text.isNotEmpty) {
                              setState(() {
                                _showUser = true;
                              });
                              updateSearchResult();
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 40,
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _showUser
                      ? Expanded(
                          child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                              future: futureResult,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (_searchUserController.text.isEmpty) {
                                  return const SizedBox();
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Connection Error!'),
                                    );
                                  }
                                  if (snapshot.data == null) {
                                    return const Center(
                                      child: Text('No Data'),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: Text('No data!'),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      UserModel user = UserModel.fromSnapshot(
                                        snapshot.data.docs[index],
                                      );
                                      debugPrint(user.userName);
                                      if (user.id ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid) {
                                        return const SizedBox();
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(
                                                userId: user.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: user.photoUrl == ""
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      'assets/default_image.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                      imageUrl: user.photoUrl,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Center(
                                                        child: FaIcon(
                                                            FontAwesomeIcons
                                                                .circleExclamation),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                              baseColor: Colors
                                                                  .grey
                                                                  .shade400,
                                                              highlightColor:
                                                                  Colors.grey
                                                                      .shade300,
                                                              child: SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      3.3,
                                                                  width: double
                                                                      .infinity)),
                                                    ),
                                                  ),
                                          ),
                                          title: Text(
                                            user.userName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                          subtitle: Text(
                                            user.email,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    color:
                                                        Colors.grey.shade300),
                                          ),
                                          trailing: const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              }),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
