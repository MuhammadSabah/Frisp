import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/category_list_view.dart';
import 'package:food_recipe_final/components/featured_recipes_list_view.dart';
import 'package:food_recipe_final/components/popular_recipes_view.dart';
import 'package:food_recipe_final/components/today_recipes_list_view.dart';

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
