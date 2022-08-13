import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/view/widgets/category_list_view.dart';
import 'package:food_recipe_final/src/view/widgets/featured_recipes_list_view.dart';
import 'package:food_recipe_final/src/view/widgets/popular_recipes_view.dart';
import 'package:food_recipe_final/src/view/widgets/today_recipes_list_view.dart';

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({Key? key}) : super(key: key);

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab>
    with AutomaticKeepAliveClientMixin {
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

  @override
  bool get wantKeepAlive => true;
}
