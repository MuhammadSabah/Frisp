import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/features/recipe_feed/widgets/recipe_post_card.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
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

  Future<void> refreshTab() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      streamResult = FirebaseFirestore.instance.collection('posts').snapshots();
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
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: streamResult,
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
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
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
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
