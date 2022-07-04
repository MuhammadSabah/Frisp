import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';

class BottomSaveButton extends StatefulWidget {
  const BottomSaveButton({Key? key}) : super(key: key);

  @override
  State<BottomSaveButton> createState() => _BottomSaveButtonState();
}

class _BottomSaveButtonState extends State<BottomSaveButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width +
          25,
      left: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width +
          25,
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: kOrangeColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Save',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
