import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/features/recipe_feed/widgets/recipe_post_card.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key, required this.user}) : super(key: key);
  final UserModel? user;
  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin {
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;

  Future<void> refreshTab() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      streamResult = FirebaseFirestore.instance
          .collection('posts')
          // .where('uid', whereIn: widget.user!.following)
          .snapshots();
      Provider.of<UserProvider>(context, listen: false).refreshUser();
      setState(() {});
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    UserModel? userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return RefreshIndicator(
      onRefresh: refreshTab,
      color: kOrangeColor,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                // .where('uid', whereIn: widget.user!.following)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Some error occurred'),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('9993993'),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text('No data'),
                );
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return const SizedBox();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    RecipePostModel post = RecipePostModel.fromSnapshot(
                        snapshot.data!.docs[index]);
                    return RecipePostCard(
                      key: const ValueKey("RecipePostCard"),
                      user: userProvider,
                      post: post,
                    );
                  }),
                );
              }
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
