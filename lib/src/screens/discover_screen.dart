import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/components/category_list_view.dart';
import 'package:food_recipe_final/src/components/featured_recipes_list_view.dart';
import 'package:food_recipe_final/src/components/popular_recipes_view.dart';
import 'package:food_recipe_final/src/components/today_recipes_list_view.dart';


class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

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
