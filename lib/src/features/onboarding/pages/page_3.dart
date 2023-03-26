import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage(
              'assets/onboarding/pages/DrawKit-cooking-kitchen-food-vector-illustrations-04-removebg-preview.png'),
          fit: BoxFit.cover,
          // color: Colors.grey,
        ),
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'Collaborate & Share With Others',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 26,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            'Share your favorite recipes with the community and help each other to develope your cooking skills.',
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
