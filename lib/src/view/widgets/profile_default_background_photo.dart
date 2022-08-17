import 'package:flutter/material.dart';

class ProfileDefaultBackgroundPhoto extends StatelessWidget {
  const ProfileDefaultBackgroundPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.3,
      decoration: const BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: AssetImage('assets/default_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
