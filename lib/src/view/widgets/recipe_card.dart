import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/api/recipe_api_model.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);
  final ResultsAPI recipe;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  // double calcRandom() {
  //   Random random = Random();
  //   double randomNum = ((random.nextDouble() * 5) + 5);
  //   return randomNum;
  // }

  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreyColor,
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2.5.toInt(),
              child: Stack(
                children: [
                  SizedBox(
                    // width: 175,
                    height: double.maxFinite,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.recipe.image!,
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
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      child: Material(
                        color: const Color.fromARGB(255, 224, 255, 221),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 22,
                          width: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.health_and_safety_outlined,
                                size: 18,
                                color: Colors.green.shade600,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  widget.recipe.healthScore!.toStringAsFixed(1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.recipe.title ?? " ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: widget.recipe.sourceName == null
                          ? Text(
                              'Unknown source',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                              maxLines: 2,
                            )
                          : Text(
                              'By ${widget.recipe.sourceName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                              maxLines: 2,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
