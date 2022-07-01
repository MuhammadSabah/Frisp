import 'package:flutter/material.dart';
import 'package:food_recipe_final/data/bookmark_manager.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    final bookmarkManager = Provider.of<BookmarkManager>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Row(
                      children: [
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  height: 800,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star_outline,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingrdients",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: recipe.ingredients?.length,
                          itemBuilder: (context, index) {
                            return Text(
                                recipe.ingredients![index].name.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
