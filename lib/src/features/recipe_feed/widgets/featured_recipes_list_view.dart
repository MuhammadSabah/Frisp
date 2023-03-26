import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedRecipesListView extends StatefulWidget {
  const FeaturedRecipesListView({Key? key}) : super(key: key);

  @override
  State<FeaturedRecipesListView> createState() =>
      _FeaturedRecipesListViewState();
}

class _FeaturedRecipesListViewState extends State<FeaturedRecipesListView> {
  // ignore: prefer_typing_uninitialized_variables
  var pageController;

  List<String> titles = [
    'Smash Burger',
    'Dark Chocolate Cake',
    'Chicken Stir Fry',
  ];
  List<dynamic> images = [
    'assets/food/feature/burger.jpg',
    'assets/food/feature/cake.png',
    'assets/food/feature/food2.png',
  ];
  List<int> minutes = [
    45,
    20,
    60,
  ];
  List<int> likes = [
    201,
    56,
    77,
  ];

  int ctnIndex = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                ctnIndex = index;
                return Container(
                  height: 350,
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade900,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0, 0.45],
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      index == 2
                          ? Positioned(
                              bottom: 50,
                              left: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 135,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Featured Recipes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontSize: 13,
                                                color: kOrangeColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      SizedBox(
                                        // height: 60,
                                        child: Text(
                                          titles[index],
                                          maxLines: 3,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.clock,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${minutes[index]}mins',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            likes[index].toString(),
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Positioned(
                              top: 12,
                              left: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 135,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Featured Recipes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontSize: 13,
                                              color: kOrangeColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          titles[index],
                                          maxLines: 3,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.clock,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${minutes[index]}mins',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            likes[index].toString(),
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
          Positioned(
            right: 30,
            bottom: 10,
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: const ScaleEffect(
                scale: 1.5,
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.white,
                activeDotColor: Colors.white,
                activePaintStyle: PaintingStyle.stroke,
                strokeWidth: 2,
                spacing: 12,
              ),
              onDotClicked: (index) {
                ctnIndex = index;
              },
            ),
          )
        ],
      ),
    );
  }
}
