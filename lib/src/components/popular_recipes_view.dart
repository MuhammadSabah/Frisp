import 'package:flutter/material.dart';

class PopularRecipesListView extends StatefulWidget {
  PopularRecipesListView({Key? key}) : super(key: key);

  @override
  State<PopularRecipesListView> createState() =>
      _PopularRecipesListViewViewState();
}

class _PopularRecipesListViewViewState extends State<PopularRecipesListView> {
  List<Container> popularContainers = [
    Container(
      height: 260,
      color: Colors.grey,
    ),
    Container(
      height: 260,
      color: Colors.purple,
    ),
    Container(
      height: 260,
      color: Colors.amber,
    ),
    Container(
      height: 260,
      color: Colors.red,
    ),
    Container(
      height: 260,
      color: Colors.pink,
    ),
    Container(
      height: 260,
      color: Colors.green,
    ),
  ];

  int popularIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Recipes",
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: popularContainers.length,
          itemBuilder: (context, index) {
            popularIndex = index;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: popularContainers[popularIndex],
            );
          },
        ),
      ],
    );
  }
}
