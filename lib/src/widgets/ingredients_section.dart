import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/data/class_models/ingredient_model.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({
    Key? key,
    required this.ingredients,
  }) : super(key: key);
  final List<IngredientModel> ingredients;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            // physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) {
              return const SizedBox(height: 6);
            },
            primary: false,
            shrinkWrap: true,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return Text(
                '${ingredients[index].name}',
                style: Theme.of(context).textTheme.headline3,
              );
            },
          ),
        ],
      ),
    );
  }
}
