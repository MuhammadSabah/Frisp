import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedRecipesListView extends StatefulWidget {
  const FeaturedRecipesListView({Key? key}) : super(key: key);

  @override
  State<FeaturedRecipesListView> createState() =>
      _FeaturedRecipesListViewState();
}

class _FeaturedRecipesListViewState extends State<FeaturedRecipesListView> {
  var pageController;

  List<Container> containers = [
    Container(
      height: 350,
      color: Colors.grey,
    ),
    Container(
      height: 350,
      color: Colors.purple,
    ),
    Container(
      height: 350,
      color: Colors.amber,
    ),
  ];

  int ctnIndex = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: PageView.builder(
            // physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: containers.length,
            itemBuilder: (BuildContext context, int index) {
              ctnIndex = index;
              return containers[ctnIndex];
            },
          ),
        ),
        Positioned(
          right: 30,
          bottom: 20,
          child: SmoothPageIndicator(
            controller: pageController,
            count: containers.length,
            // ignore: prefer_const_constructors
            effect: ScaleEffect(
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
    );
  }
}
