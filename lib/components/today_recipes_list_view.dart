import 'package:flutter/material.dart';

class TodayRecipesListView extends StatefulWidget {
  TodayRecipesListView({Key? key}) : super(key: key);

  @override
  State<TodayRecipesListView> createState() => _TodayRecipesListViewState();
}

class _TodayRecipesListViewState extends State<TodayRecipesListView> {
  List<Container> gridContainers = [
    Container(
      height: 80,
      width: 220,
      color: Colors.grey,
    ),
    Container(
      height: 80,
      width: 220,
      color: Colors.purple,
    ),
    Container(
      height: 80,
      width: 220,
      color: Colors.amber,
    ),
    Container(
      height: 80,
      width: 220,
      color: Colors.red,
    ),
    Container(
      height: 80,
      width: 220,
      color: Colors.pink,
    ),
    Container(
      height: 80,
      width: 220,
      color: Colors.green,
    ),
  ];

  int gridIndex = 0;

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
                "Today Recipes",
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
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: gridContainers.length,
            itemBuilder: (context, index) {
              gridIndex = index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: gridContainers[gridIndex],
              );
            },
          ),
        ),
      ],
    );
  }
}
