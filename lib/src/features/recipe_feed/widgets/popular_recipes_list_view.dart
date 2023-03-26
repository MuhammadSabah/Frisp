import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularRecipesListView extends StatefulWidget {
  const PopularRecipesListView({Key? key}) : super(key: key);

  @override
  State<PopularRecipesListView> createState() =>
      _PopularRecipesListViewViewState();
}

class _PopularRecipesListViewViewState extends State<PopularRecipesListView> {
  int popularIndex = 0;
  List<String> titles = [
    'Ratatouille Recipe by Tasty',
    'Chocolate Chia Seed Parfaits with Date Syrup',
    'Portuguese Style Chicken Burger',
    'Blackberry Lavender Naked Cake with White Chocolate Buttercream',
    'Grilled Cilantro Lime Chicken Skewers',
    'Campfire Caprese Brie',
    'Best Beef Birria and Birria Tacos',
    'One Pan Balsamic Chicken and Veggies',
  ];
  List<dynamic> images = [
    'assets/food/popular/ratatoullie.jpg',
    'assets/food/popular/chocolate_chia.jpg',
    'assets/food/popular/burger.jpg',
    'assets/food/popular/lavender_cake.jpg',
    'assets/food/popular/beef_toko.jpg',
    'assets/food/popular/campfire.jpg',
    'assets/food/popular/beef_and_taco.jpg',
    'assets/food/popular/chicken.jpg',
  ];
  List<int> minutes = [
    35,
    60,
    120,
    25,
    45,
    25,
    55,
    75,
  ];
  List<int> likes = [
    27,
    95,
    19,
    315,
    53,
    204,
    111,
    89,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Recipes",
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
        ),
        Row(
          children: [
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 2.0 / 3.2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: 8,
                      (context, index) {
                        popularIndex = index;
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(19),
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
                                            borderRadius:
                                                const BorderRadius.only(
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
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Colors.grey
                                                            .withOpacity(0.2),
                                                        Colors.grey
                                                            .withOpacity(0.15),
                                                      ],
                                                      stops: const [0.0, 1.0],
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
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
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              likes[index]
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const FaIcon(
                                                              FontAwesomeIcons
                                                                  .clock,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              '${minutes[index]}mins',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
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
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  // width: 240,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
      ],
    );
  }
}
