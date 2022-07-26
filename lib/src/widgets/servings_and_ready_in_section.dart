import 'package:flutter/material.dart';

class ServingsAndReadyInSection extends StatelessWidget {
  const ServingsAndReadyInSection(
      {Key? key, required this.readyInMinutes, required this.servings})
      : super(key: key);
  final int readyInMinutes;
  final int servings;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'Servings  ',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    '$servings pp',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ready In  ',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    '${readyInMinutes}m',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
