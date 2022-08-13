import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    Key? key,
    required this.recipePost,
  }) : super(key: key);
  final RecipePostModel? recipePost;
  // static MaterialPage page() {
  //   return MaterialPage(
  //     name: AppPages.commentsPath,
  //     key: ValueKey(AppPages.commentsPath),
  //     child: const CommentsScreen(),
  //   );
  // }

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _commentController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? _returnedCommentSnapshots;
  @override
  void initState() {
    super.initState();
    _returnedCommentSnapshots = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.recipePost!.postId)
        .collection('comments')
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    final commentsProvider =
        Provider.of<AppStateManager>(context, listen: false);
    final postProvider =
        Provider.of<RecipePostProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
          title: Text(
            'Comments',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: _returnedCommentSnapshots,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: CommentModel.fromSnapshot(
                          snapshot.data!.docs[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is empty';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        controller: _commentController,
                        cursorColor: kOrangeColor,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            splashRadius: 20,
                            onPressed: () async {
                              final validForm =
                                  _formKey.currentState!.validate();
                              if (validForm) {
                                // !: Post comment.
                                postProvider.postComment(
                                  userName: user!.userName,
                                  profileImage: user.photoUrl,
                                  postId: widget.recipePost!.postId,
                                  text: _commentController.text,
                                  uid: user.id,
                                );
                                _commentController.clear();
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: kOrangeColor,
                            ),
                          ),
                          counterText: ' ',
                          fillColor: kGreyColor,
                          filled: true,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'Comment',
                          hintStyle:
                              Theme.of(context).textTheme.headline4!.copyWith(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
