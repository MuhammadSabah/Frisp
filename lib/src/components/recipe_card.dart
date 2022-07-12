import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    // width: 175,
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.image!,
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
                        elevation: 8,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 22,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 224, 255, 221),
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 77,
                  width: 160,
                  child: Text(
                    widget.recipe.title!,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
