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

          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.red.shade400,
              ),
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} dismissed'),
                  duration: const Duration(
                    milliseconds: 2000,
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.green.shade300,
                    onPressed: () {
                      manager.addItem(item);
                    },
                  ),
                ),
              );
            },
            child: InkWell(
              onTap: () {
                manager.shoppingItemTapped(index);
              },
              child: ShoppingTile(
                key: Key(item.id),
                item: item,
              ),
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
