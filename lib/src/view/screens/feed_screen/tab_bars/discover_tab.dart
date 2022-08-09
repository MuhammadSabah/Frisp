import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/view/widgets/category_list_view.dart';
import 'package:food_recipe_final/src/view/widgets/featured_recipes_list_view.dart';
import 'package:food_recipe_final/src/view/widgets/popular_recipes_view.dart';
import 'package:food_recipe_final/src/view/widgets/today_recipes_list_view.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        FeaturedRecipesListView(),
        TodayRecipesListView(),
        CategoryListView(),
        PopularRecipesListView(),
      ],
    );
  }
}
