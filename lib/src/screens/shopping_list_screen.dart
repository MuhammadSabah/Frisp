import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/components/shopping_tile.dart';
import 'package:food_recipe_final/src/models/shopping_manager.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key, required this.manager}) : super(key: key);

  final ShoppingManager manager;
  @override
  Widget build(BuildContext context) {
    final shoppingItems = manager.shoppingItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = shoppingItems[index];

          return InkWell(
            onTap: () {
              manager.shoppingItemTapped(index);
            },
            child: ShoppingTile(
              item: item,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 16);
        },
        itemCount: shoppingItems.length,
      ),
    );
  }
}
