import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:food_recipe_final/src/repository/bookmark_interface.dart';
import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';
import 'package:food_recipe_final/src/view/widgets/bottom_save_button.dart';
import 'package:food_recipe_final/src/view/widgets/details_sliver_app_bar.dart';
import 'package:food_recipe_final/src/view/widgets/details_title_section.dart';
import 'package:food_recipe_final/src/view/widgets/ingredients_section.dart';
import 'package:food_recipe_final/src/view/widgets/instructions_section.dart';
import 'package:food_recipe_final/src/view/widgets/nutritions_section.dart';
import 'package:food_recipe_final/src/view/widgets/servings_and_ready_in_section.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);
  final RecipeModel recipe;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late List nutritionsList = [];
  late List<bool>? tagsList = [];
  late List<String>? keysList = [];
  late Map<String, dynamic>? tagsMap;

  // late Map<String, dynamic>? tagsMapFiltered;
  @override
  Widget build(BuildContext context) {
    final bookmark = Provider.of<BookmarkInterface>(context);
    nutritionsList = widget.recipe.nutrition!.nutrients!
        .where(
          (nutrition) =>
              nutrition.name == 'Calories' ||
              nutrition.name == 'Fat' ||
              nutrition.name == 'Carbohydrates' ||
              nutrition.name == 'Sugar' ||
              nutrition.name == 'Protein' ||
              nutrition.name == 'Fiber',
        )
        .toList();

    tagsList?.add(widget.recipe.vegetarian!);
    tagsList?.add(widget.recipe.vegan!);
    tagsList?.add(widget.recipe.dairyFree!);
    tagsList?.add(widget.recipe.glutenFree!);
    tagsList?.add(widget.recipe.veryHealthy!);
    tagsList?.add(widget.recipe.veryPopular!);

    tagsMap = {
      "Vegetarian": tagsList![0],
      "Vegan": tagsList![1],
      "DairyFree": tagsList![2],
      "GlutenFree": tagsList![3],
      "VeryHealthy": tagsList![4],
      "VeryPopular": tagsList![5],
    };

    tagsMap!.removeWhere((key, value) => value == false);
    keysList = tagsMap!.keys.toList();
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                DetailsSliverAppBar(
                  imgUrl: widget.recipe.image ?? "",
                  title: widget.recipe.title ?? '',
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsTitleSection(
                            diets: widget.recipe.diets ?? [],
                            dishTypes: widget.recipe.dishTypes ?? [],
                            sourceName: widget.recipe.creditsText ?? '',
                            sourceUrl: widget.recipe.sourceUrl ?? '',
                            keysList: keysList ?? [],
                            title: widget.recipe.title ?? '',
                          ),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          ServingsAndReadyInSection(
                            readyInMinutes: widget.recipe.readyInMinutes!,
                            servings: widget.recipe.servings!,
                          ),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          IngredientsSection(
                            ingredients: widget.recipe.ingredients!,
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          NutritionsSection(
                            nutritionsList: nutritionsList,
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          InstructionsSection(
                            instructions: widget.recipe.instructions,
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BottomSaveButton(
              saveRecipe: () {
                bookmark.insertRecipe(widget.recipe);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Recipe Saved!'),
                    duration: const Duration(
                      milliseconds: 2300,
                    ),
                    backgroundColor: kOrangeColorTint,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor:
                          settingsManager.darkMode ? kBlackColor : Colors.white,
                      onPressed: () {
                        bookmark.deleteRecipe(widget.recipe);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
