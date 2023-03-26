import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image:
              AssetImage('assets/onboarding/pages/list-removebg-preview.png'),
          fit: BoxFit.cover,
          color: Colors.grey,
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Text(
            'Grocery List For When You Shop',
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
            'Take the grocery list from you cart to your nearest grocery store and buy the ingredients.',
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
