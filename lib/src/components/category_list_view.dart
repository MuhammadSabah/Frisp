import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({Key? key}) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<Container> categoryContainers = [
    Container(
      height: 40,
      width: 150,
      color: Colors.grey,
    ),
    Container(
      height: 40,
      width: 150,
      color: Colors.purple,
    ),
    Container(
      height: 40,
      width: 150,
      color: Colors.amber,
    ),
    Container(
      height: 40,
      width: 150,
      color: Colors.red,
    ),
    Container(
      height: 40,
      width: 150,
      color: Colors.pink,
    ),
    Container(
      height: 40,
      width: 150,
      color: Colors.green,
    ),
  ];

  int categoryIndex = 0;

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
                "Category",
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categoryContainers.length,
            itemBuilder: (context, index) {
              categoryIndex = index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: categoryContainers[categoryIndex],
              );
            },
          ),
        ),
      ],
    );
  }
}
