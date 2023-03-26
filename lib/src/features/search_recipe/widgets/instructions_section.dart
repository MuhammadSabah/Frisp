import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/data_class_models/instruction_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class InstructionsSection extends StatelessWidget {
  const InstructionsSection({
    Key? key,
    required this.instructions,
  }) : super(key: key);
  final List<InstructionModel>? instructions;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              separatorBuilder: ((context, index) =>
                  const SizedBox(height: 14)),
              itemCount: instructions![0].steps!.length,
              itemBuilder: (context, index) {
                int i = index + 1;
                return Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      width: 20,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: settingsManager.darkMode
                            ? Colors.white
                            : kOrangeColor,
                      ),
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: settingsManager.darkMode
                                ? kOrangeColor
                                : Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "${instructions![0].steps![index].step}",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              height: 1.6,
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
