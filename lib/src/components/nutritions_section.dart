import 'package:flutter/material.dart';

class NutritionsSection extends StatelessWidget {
  const NutritionsSection({
    Key? key,
    required this.nutritionsList,
  }) : super(key: key);
  final List nutritionsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nutritions",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            separatorBuilder: ((context, index) => const SizedBox(height: 6)),
            itemCount: nutritionsList!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text("${nutritionsList[index].name}: ",
                      style: Theme.of(context).textTheme.headline3),
                  Text(
                    "${nutritionsList[index].amount?.toStringAsFixed(1)}${nutritionsList[index].unit}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
