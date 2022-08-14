import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';
import 'package:intl/intl.dart';

class ShoppingTile extends StatelessWidget {
  const ShoppingTile({
    Key? key,
    required this.item,
    this.onComplete,
  }) : super(key: key);

  final ShoppingItem item;
  final Function(bool?)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 10.0,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0).copyWith(left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(height: 1.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      buildDate(context),
                      const SizedBox(height: 6),
                      buildImportance(context),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        item.quantity.toString(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 19,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDate(BuildContext context) {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Widget buildImportance(BuildContext context) {
    if (item.importance == Importance.low) {
      return Text(
        'Low',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 15,
            ),
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Medium',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.yellow.shade400,
            fontSize: 15),
      );
    }
    if (item.importance == Importance.high) {
      return Text(
        'High',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade400,
              fontSize: 15,
            ),
      );
    } else {
      return Text(
        '',
        style: Theme.of(context).textTheme.bodyText2,
      );
    }
  }
}
