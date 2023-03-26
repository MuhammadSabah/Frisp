import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/data_class_models/ingredient_model.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({
    Key? key,
    required this.ingredients,
  }) : super(key: key);
  final List<IngredientModel> ingredients;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, index) {
                return const SizedBox(height: 10);
              },
              primary: false,
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                // int i = index + 1;
                return Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    // Container(
                    //   width: 20,
                    //   height: 20,
                    //   decoration: const BoxDecoration(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(4),
                    //     ),
                    //     color: Colors.white,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       '$i',
                    //       style: const TextStyle(
                    //         color: kBlackColor,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${ingredients[index].name}',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 15, height: 1.6),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
