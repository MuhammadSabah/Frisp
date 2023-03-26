import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';

class BottomSaveButton extends StatefulWidget {
  const BottomSaveButton({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  State<BottomSaveButton> createState() => _BottomSaveButtonState();
}

class _BottomSaveButtonState extends State<BottomSaveButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: kOrangeColor,
        elevation: 4,
        child: InkWell(
          onTap: widget.callBack,
          child: Ink(
            height: 52,
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
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
    );
  }
}
