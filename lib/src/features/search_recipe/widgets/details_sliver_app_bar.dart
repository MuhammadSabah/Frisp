import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class DetailsSliverAppBar extends StatelessWidget {
  const DetailsSliverAppBar({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return SliverAppBar(
      backgroundColor: settingsManager.darkMode ? kBlackColor : Colors.white,
      stretch: true,
      pinned: true,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imgUrl,
          placeholder: (context, url) => const Center(
            child: FaIcon(
              FontAwesomeIcons.spinner,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => const FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: Colors.white,
          ),
        ),
      ),
      leading: GestureDetector(
        key: const Key('backButton'),
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
            debugPrint("Nothing for now.");
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
