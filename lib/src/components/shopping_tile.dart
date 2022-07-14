import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
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
    return Container(
      decoration: const BoxDecoration(
        color: kGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8.0,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 4),
                  buildDate(context),
                  const SizedBox(height: 4),
                  buildImportance(context),
                ],
              ),
            ],
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
    );
  }

  // Widget buildCheckbox() {
  //   return Checkbox(
  //     value: item.isComplete,
  //     onChanged: onComplete,
  //   );
  // }

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
        style: Theme.of(context).textTheme.bodyText2,
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Medium',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.yellow.shade400,
            ),
      );
    }
    if (item.importance == Importance.high) {
      return Text(
        'High',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade400,
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
