import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class BookmarkCard extends StatefulWidget {
  const BookmarkCard(
      {Key? key, required this.recipe, required this.deleteCallback})
      : super(key: key);
  final RecipeModel recipe;
  final Function() deleteCallback;
  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  final checkBoxValues = <int, bool>{};
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppPages.recipeDetails,
                        arguments: widget.recipe);
                  },
                  child: SizedBox(
                    height: 120,
                    width: double.maxFinite,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.recipe.image!,
                      placeholder: (context, url) => const Center(
                        child: FaIcon(
                          FontAwesomeIcons.spinner,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: widget.deleteCallback,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 18,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: settingsManager.darkMode ? kGreyColor : kGreyColor5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.recipe.ingredients?.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          value: checkBoxValues.containsKey(index) &&
                              checkBoxValues[index]!,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(
                                () {
                                  checkBoxValues[index] = newValue;
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.recipe.ingredients![index].name.toString(),
                          style: Theme.of(context).textTheme.displaySmall,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
