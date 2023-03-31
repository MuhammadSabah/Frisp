import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/comment_model.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/features/comment/widgets/comment_card.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    Key? key,
    required this.recipePost,
  }) : super(key: key);
  final RecipePostModel? recipePost;

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
        .orderBy("dateCommented", descending: true)
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
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    final postProvider =
        Provider.of<RecipePostProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          useMaterial3: false,
        ),
        child: Scaffold(
          key: const Key('commentsScreen'),
          appBar: AppBar(
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: settingsManager.darkMode ? Colors.white : Colors.black,
                size: 24,
              ),
            ),
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  color: settingsManager.darkMode ? Colors.white : Colors.black,
                  size: 24,
                ),
              ),
            ],
            title: Text(
              'Comments',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _returnedCommentSnapshots,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12)
                            .copyWith(top: 8),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  key: const Key('commentField'),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field is empty';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                  controller: _commentController,
                                  cursorColor: kOrangeColor,
                                  autofocus: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      key: const Key('sendCommentButton'),
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
                                    fillColor: settingsManager.darkMode
                                        ? kGreyColor
                                        : kGreyColor4,
                                    filled: true,
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.all(14),
                                    hintText: 'Comment',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 15,
                                          color: settingsManager.darkMode
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade700,
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                            user: user,
                            comment: CommentModel.fromSnapshot(
                              snapshot.data!.docs[index],
                            ),
                            postId: widget.recipePost!.postId,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
