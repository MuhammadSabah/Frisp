import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class PostDetailTitleSection extends StatelessWidget {
  const PostDetailTitleSection({
    Key? key,
    required this.recipePost,
  }) : super(key: key);
  final RecipePostModel recipePost;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'By ${recipePost.userName}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  Text(
                    recipePost.likes.length.toString(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: settingsManager.darkMode
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16,
                        ),
                    maxLines: 1,
                  ),
                  const SizedBox(width: 8),
                  const FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: kOrangeColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              recipePost.title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 24,
                    height: 1.4,
                  ),
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              recipePost.description,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    height: 1.6,
                    color: Colors.grey.shade500,
                  ),
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
