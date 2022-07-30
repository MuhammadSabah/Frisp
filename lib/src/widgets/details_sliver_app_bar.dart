import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_theme.dart';

class DetailsSliverAppBar extends StatelessWidget {
  const DetailsSliverAppBar({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kBlackColor,
      stretch: true,
      // pinned: true,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: imgUrl,
          fit: BoxFit.cover,
          fadeInCurve: Curves.easeInOut,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: kGreyColor,
              size: 20,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("Nothing for now.");
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.9),
              child: const FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: kGreyColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
