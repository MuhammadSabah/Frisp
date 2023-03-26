import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/enums/importance_enum.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Ink(
      decoration: BoxDecoration(
        color: settingsManager.darkMode ? kGreyColor : kGreyColor4,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
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
                color: Color(item.color),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
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
                                  .displayMedium!
                                  .copyWith(
                                    height: 1.4,
                                    fontSize: 17,
                                  ),
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
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontSize: 16,
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
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget buildImportance(BuildContext context) {
    if (item.importance == ImportanceEnum.low.type) {
      return Text(
        'Low',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 13,
            ),
      );
    } else if (item.importance == ImportanceEnum.medium.type) {
      return Text(
        'Medium',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.yellow.shade400,
            fontSize: 13),
      );
    }
    if (item.importance == ImportanceEnum.high.type) {
      return Text(
        'High',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade400,
              fontSize: 13,
            ),
      );
    } else {
      return Text(
        '',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
  }
}
