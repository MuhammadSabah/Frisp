import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:provider/provider.dart';

class BottomSaveButton extends StatefulWidget {
  const BottomSaveButton({Key? key, this.saveRecipe}) : super(key: key);

  final Function()? saveRecipe;

  @override
  State<BottomSaveButton> createState() => _BottomSaveButtonState();
}

class _BottomSaveButtonState extends State<BottomSaveButton> {
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return Positioned(
      bottom: 10,
      right: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width +
          25,
      left: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width +
          25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: kOrangeColor,
          elevation: 4,
          child: InkWell(
            onTap: widget.saveRecipe,
            child: Ink(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
