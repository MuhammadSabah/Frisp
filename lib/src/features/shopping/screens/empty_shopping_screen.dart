import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyShoppingScreen extends StatelessWidget {
  const EmptyShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1.2,
            child: SvgPicture.asset('assets/empty.svg'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'No Items!',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
