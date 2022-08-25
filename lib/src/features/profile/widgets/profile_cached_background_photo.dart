import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCachedBackgroundPhoto extends StatelessWidget {
  const ProfileCachedBackgroundPhoto({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        imageUrl: user.photoUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Center(
          child: FaIcon(FontAwesomeIcons.circleExclamation),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3.3,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
