import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: GestureDetector(
          onTap: () {
            Provider.of<AppStateManager>(context, listen: false).logOut();
          },
          child: const Text(
            'Log out',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
