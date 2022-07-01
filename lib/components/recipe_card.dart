import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
import '../models/recipe_api_model.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);
  final RecipeAPI recipe;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          width: 175,
                          height: 210,
                          child: CachedNetworkImage(
                            imageUrl: widget.recipe.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const SizedBox(
                              width: 40,
                              height: 160,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          )),
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
                          elevation: 8,
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Center(
                              child: Icon(
                                _isSelected
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.green,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 65,
                    width: 160,
                    child: Text(
                      widget.recipe.label,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
