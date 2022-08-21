import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/message_provider.dart';
import 'package:food_recipe_final/src/view/screens/messages_screen.dart';
import 'package:provider/provider.dart';

class ProfileSendMessageButton extends StatelessWidget {
  const ProfileSendMessageButton({
    Key? key,
    required this.userId,
    required this.user,
  }) : super(key: key);
  final String userId;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    return IconButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(
              userId: userId,
              user: user,
            ),
          ),
        );
        await messageProvider.createUserContactsCollection(
          uid: userId,
          user: user,
        );
      },
      splashRadius: 20,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.solidPaperPlane,
            color: kGreyColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
