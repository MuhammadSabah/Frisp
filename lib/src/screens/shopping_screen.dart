import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/providers/shopping_manager.dart';
import 'package:food_recipe_final/src/screens/empty_shopping_screen.dart';
import 'package:food_recipe_final/src/screens/shopping_list_screen.dart';
import 'package:provider/provider.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        label: Text(
          "Add Item",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onPressed: () {
          final manager = Provider.of<ShoppingManager>(context, listen: false);
          manager.createNewItem();
        },
        icon: const FaIcon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              color: Colors.grey.shade600,
              height: 1,
            ),
          ),
        ),
        title: Text(
          "Shopping List",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _buildShoppingScreen(),
    );
  }

  Widget _buildShoppingScreen() {
    return Consumer<ShoppingManager>(
      builder: (context, manager, child) {
        if (manager.shoppingItems.isNotEmpty) {
          return ShoppingListScreen(manager: manager);
        } else {
          return const EmptyShoppingScreen();
        }
      },
    );
  }
}
