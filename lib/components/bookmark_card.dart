import 'package:flutter/material.dart';
import 'package:food_recipe_final/data/bookmark_manager.dart';
import 'package:provider/provider.dart';

class BookmarkCard extends StatefulWidget {
  BookmarkCard({Key? key}) : super(key: key);

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  final checkBoxValues = Map<int, bool>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkManager>(
      builder: (context, manager, child) {
        final ingredients = manager.findAllIngredients();

        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
                // color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: checkBoxValues.containsKey(index) &&
                        checkBoxValues[index] != null,
                    title: Text(ingredients[index].name ?? ''),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          checkBoxValues[index] = newValue;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
