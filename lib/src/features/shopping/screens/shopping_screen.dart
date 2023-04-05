import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/shopping_provider.dart';
import 'package:food_recipe_final/src/features/shopping/screens/empty_shopping_screen.dart';
import 'package:food_recipe_final/src/features/shopping/screens/shopping_list_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<String> sortByItems = ['Quantity', 'Date', 'Importance'];
  bool isArrowUp = false;
  @override
  Widget build(BuildContext context) {
    final shoppingProvider =
        Provider.of<ShoppingProvider>(context, listen: true);
    return Scaffold(
      key: const Key('shoppingScreen'),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('addShoppingItemButton'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        label: Text(
          
          "Add Item",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
        ),
        onPressed: () {
          shoppingProvider.createNewItem();
          Navigator.pushNamed(context, AppPages.shoppingItemDetails);
        },
        icon: const FaIcon(
          FontAwesomeIcons.plus,
          size: 20,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        elevation: 0,
        centerTitle: false,
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
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              dropdownWidth: 120,
              itemPadding: const EdgeInsets.only(left: 10),
              hint: Text(
                shoppingProvider.getSortValue == ''
                    ? 'Sort by'
                    : shoppingProvider.getSortValue,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 13,
                    ),
              ),
              items: sortByItems.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value is String) {
                  shoppingProvider.setSortValue(value);
                }
              },
            ),
          ),
          IconButton(
            splashRadius: 20,
            color: kOrangeColor,
            onPressed: () {
              String sortVal = shoppingProvider.getSortValue;
              if (sortVal == 'Quantity') {
                if (isArrowUp) {
                  shoppingProvider.sortByQuantityAscending();
                } else {
                  shoppingProvider.sortByQuantityDescending();
                }
              }
              if (sortVal == 'Date') {
                if (isArrowUp) {
                  shoppingProvider.sortByDateAscending();
                } else {
                  shoppingProvider.sortByDateDescending();
                }
              }
              if (sortVal == 'Importance') {
                if (isArrowUp) {
                  shoppingProvider.sortByImportanceAscending();
                } else {
                  shoppingProvider.sortByImportanceDescending();
                }
              }
              setState(() {
                isArrowUp = !isArrowUp;
              });
            },
            icon: FaIcon(
              isArrowUp ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
              size: 16,
            ),
          ),
        ],
        title: Text(
          "Shopping List",
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
        ),
      ),
      body: _buildShoppingScreen(),
    );
  }

  Widget _buildShoppingScreen() {
    return Consumer<ShoppingProvider>(
      builder: (context, manager, child) {
        if (manager.getShoppingItems().isNotEmpty) {
          return ShoppingListScreen(manager: manager);
        } else {
          return const EmptyShoppingScreen();
        }
      },
    );
  }
}
