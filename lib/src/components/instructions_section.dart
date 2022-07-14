import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/data/class_models/instruction_model.dart';

class InstructionsSection extends StatelessWidget {
  const InstructionsSection({
    Key? key,
    required this.instructions,
  }) : super(key: key);
  final List<InstructionModel>? instructions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            separatorBuilder: ((context, index) => const SizedBox(height: 6)),
            itemCount: instructions![0].steps!.length,
            itemBuilder: (context, index) {
              return Text(
                "${index + 1}- ${instructions![0].steps![index].step}",
                style: Theme.of(context).textTheme.headline3,
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
