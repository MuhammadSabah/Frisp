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
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nutritions",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 10)),
                itemCount: nutritionsList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        "${nutritionsList[index].name}: ",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        "${nutritionsList[index].amount?.toStringAsFixed(1)}${nutritionsList[index].unit}",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ],
                  );
                  // return Column(
                  //   children: [
                  //     Text(
                  //       "${nutritionsList[index].name}: ",
                  //       style:
                  //           Theme.of(context).textTheme.headline3!.copyWith(
                  //                 fontSize: 15,
                  //               ),
                  //     ),
                  //     Container(
                  //       height: 40,
                  //       width: 160,
                  //       decoration: BoxDecoration(
                  //         // color: kOrangeColor,
                  //         borderRadius: const BorderRadius.all(
                  //           Radius.circular(1000),
                  //         ),
                  //         border: Border.all(color: kOrangeColor, width: 1),
                  //       ),
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           const SizedBox(height: 8),
                  //           Text(
                  //             "${nutritionsList[index].amount?.toStringAsFixed(1)}${nutritionsList[index].unit}",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .headline3!
                  //                 .copyWith(
                  //                   fontSize: 15,
                  //                 ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
