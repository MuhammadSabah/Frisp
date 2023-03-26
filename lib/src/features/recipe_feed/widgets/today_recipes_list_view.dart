import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayRecipesListView extends StatefulWidget {
  const TodayRecipesListView({Key? key}) : super(key: key);

  @override
  State<TodayRecipesListView> createState() => _TodayRecipesListViewState();
}

class _TodayRecipesListViewState extends State<TodayRecipesListView> {
  List<String> titles = [
    '5 ingredient Beef Stir-fry',
    'Best Grilled Chicken Breast',
    'Vegan Mixed Berry Scones',
    'Most Delicious Teriyaki Chicken',
    'Grilled Cilantro Lime Chicken Skewers',
  ];
  List<dynamic> images = [
    'assets/food/today/japanese.jpg',
    'assets/food/today/grilled.jpg',
    'assets/food/today/bread.jpg',
    'assets/food/today/vegan.jpg',
    'assets/food/today/bbq.jpg',
  ];
  List<int> minutes = [
    35,
    15,
    120,
    75,
    50,
  ];
  List<int> likes = [
    121,
    33,
    90,
    75,
    314,
  ];

  int itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22)
                .copyWith(top: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today Recipes",
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
          Expanded(
            // height: 260,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 5,
                    (context, index) {
                      itemIndex = index;
                      return Padding(
                        padding: itemIndex == 0
                            ? const EdgeInsets.only(left: 8)
                            : const EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 240,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.grey.withOpacity(0.2),
                                                  Colors.grey.withOpacity(0.15),
                                                ],
                                                stops: const [0.0, 1.0],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        likes[index].toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const FaIcon(
                                                        FontAwesomeIcons.clock,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${minutes[index]}mins',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 240,
                              // height: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titles[index],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
