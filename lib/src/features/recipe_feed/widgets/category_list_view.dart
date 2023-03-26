import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int categoryIndex = 0;
  static Color iconColor = Colors.white;
  static double? iconSize = 30;
  List<FaIcon> categoryIcons = [
    FaIcon(
      FontAwesomeIcons.utensils,
      color: iconColor,
      size: iconSize,
    ),
    FaIcon(
      FontAwesomeIcons.mugSaucer,
      color: iconColor,
    ),
    FaIcon(
      FontAwesomeIcons.bacon,
      color: iconColor,
      size: iconSize,
    ),
    FaIcon(
      FontAwesomeIcons.leaf,
      color: iconColor,
      size: iconSize,
    ),
  ];
  List<String> titles = [
    'main',
    'breakfast',
    'meat',
    'vegan',
  ];

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Category",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 4,
                  (context, index) {
                    categoryIndex = index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: settingsProvider.darkMode
                              ? kGreyColor
                              : Colors.grey.shade600,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            categoryIcons[index],
                            const SizedBox(height: 10),
                            Text(
                              titles[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
