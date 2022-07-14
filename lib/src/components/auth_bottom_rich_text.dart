import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthBottomRichText extends StatelessWidget {
  const AuthBottomRichText({
    Key? key,
    required this.onTap,
    required this.detailText,
    required this.clickableText,
  }) : super(key: key);
  final Function()? onTap;
  final String detailText;
  final String clickableText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: detailText,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
              ),
              TextSpan(
                text: clickableText,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
