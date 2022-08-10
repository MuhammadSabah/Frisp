import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.commentsPath,
      key: ValueKey(AppPages.commentsPath),
      child: const CommentsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider =
        Provider.of<AppStateManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            commentsProvider.commentsClicked(false);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text('Comments'),
      ),
    );
  }
}
