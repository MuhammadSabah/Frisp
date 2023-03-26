import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 2.2,
          child: const Image(
            image: AssetImage(
                'assets/onboarding/pages/DrawKit-cooking-kitchen-food-vector-illustrations-11-removebg-preview.png'),
            fit: BoxFit.cover,

            // color: kOrangeColor,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'All Your Favorite Recipes In One Place',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 26,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'Save time on planning by having your favorite recipes within reach.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  height: 1.4,
                  color: Colors.grey,
                ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
