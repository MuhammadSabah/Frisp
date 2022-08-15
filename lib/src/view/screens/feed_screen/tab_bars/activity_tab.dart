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

  @override
  Widget build(BuildContext context) {
    final commentsProvider =
        Provider.of<AppStateManager>(context, listen: false);
    UserModel? userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: LinearProgressIndicator(
                color: kOrangeColor,
                backgroundColor: Colors.white,
              ),
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
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                return RecipePostCard(
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
