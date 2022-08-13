import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/screens/comments_screen/comments_screen.dart';
import 'package:food_recipe_final/src/view/widgets/recipe_post_card.dart';
import 'package:provider/provider.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin {
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;
  @override
  void initState() {
    super.initState();
    streamResult = FirebaseFirestore.instance.collection('posts').snapshots();
  }

  // Future<void> _refresh() async {
  //   await Future.delayed(const Duration(milliseconds: 3300), () {
  //     Provider.of<UserProvider>(context, listen: false).refreshUser();
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });

  @override
  Widget build(BuildContext context) {
    // _refresh();
    final commentsProvider =
        Provider.of<AppStateManager>(context, listen: false);
    UserModel? userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Some error occurred'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(''),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text(''),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                return RecipePostCard(
                  onCommentPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                                recipePost: RecipePostModel.fromSnapshot(
                                  snapshot.data!.docs[index],
                                ),
                              )),
                    );
                  },
                  user: userProvider,
                  post: RecipePostModel.fromSnapshot(
                    snapshot.data!.docs[index],
                  ),
                );
              }),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
