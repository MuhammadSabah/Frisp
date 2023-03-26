import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';

class AuthConfirmButton extends StatelessWidget {
  const AuthConfirmButton({
    Key? key,
    required this.title,
    required this.callBack,
  }) : super(key: key);
  final String title;
  final Function()? callBack;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: kOrangeColor,
        elevation: 4,
        child: InkWell(
          onTap: callBack,
          child: Ink(
            height: 50,
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
                  title,
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
