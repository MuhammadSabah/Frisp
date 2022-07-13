import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/src/components/bottom_save_button.dart';
import 'package:food_recipe_final/src/data/bookmark_interface.dart';
import 'package:food_recipe_final/src/data/class_models/recipe_model.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);
  final RecipeModel recipe;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _heartClicked = false;
  bool _starClicked = false;
  late List nutritionsList = [];
  late List<bool>? tagsList = [];
  late List<String>? keysList = [];
  late Map<String, dynamic>? tagsMap;

  // late Map<String, dynamic>? tagsMapFiltered;
  @override
  Widget build(BuildContext context) {
    final bookmark = Provider.of<BookmarkInterface>(context);
    nutritionsList = widget.recipe.nutrition!.nutrients!
        .where(
          (nutrition) =>
              nutrition.name == 'Calories' ||
              nutrition.name == 'Fat' ||
              nutrition.name == 'Carbohydrates' ||
              nutrition.name == 'Sugar' ||
              nutrition.name == 'Protein' ||
              nutrition.name == 'Fiber',
        )
        .toList();

    tagsList?.add(widget.recipe.vegetarian!);
    tagsList?.add(widget.recipe.vegan!);
    tagsList?.add(widget.recipe.dairyFree!);
    tagsList?.add(widget.recipe.glutenFree!);
    tagsList?.add(widget.recipe.veryHealthy!);
    tagsList?.add(widget.recipe.veryPopular!);

    tagsMap = {
      "Vegetarian": tagsList![0],
      "Vegan": tagsList![1],
      "DairyFree": tagsList![2],
      "GlutenFree": tagsList![3],
      "VeryHealthy": tagsList![4],
      "VeryPopular": tagsList![5],
    };

    tagsMap!.removeWhere((key, value) => value == false);
    keysList = tagsMap!.keys.toList();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  stretch: true,
                  expandedHeight: MediaQuery.of(context).size.height / 3,
                  flexibleSpace: CachedNetworkImage(
                    imageUrl: widget.recipe.image!,
                    fit: BoxFit.cover,
                    fadeInCurve: Curves.easeInOut,
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: const Icon(
                          Icons.arrow_back,
                          color: kGreyColor,
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
                          child: const Icon(
                            Icons.more_horiz,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _heartClicked = !_heartClicked;
                                            });
                                          },
                                          icon: Icon(
                                            _heartClicked == false
                                                ? Icons.favorite_border_outlined
                                                : Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _starClicked = !_starClicked;
                                            });
                                          },
                                          icon: Icon(
                                            _starClicked == false
                                                ? Icons.star_outline
                                                : Icons.star,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                color: Colors.white60,
                                                width: 1,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            child: Text(
                                              'Open Source',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.recipe.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: 28,
                                      ),
                                  maxLines: 4,
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  height:
                                      widget.recipe.dishTypes!.isEmpty ? 0 : 25,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'Dish Types: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              fontSize: 14,
                                              color: Colors.grey.shade300,
                                            ),
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              widget.recipe.dishTypes!.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              widget.recipe.dishTypes![index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                            );
                                          },
                                          separatorBuilder: (_, index) {
                                            return const SizedBox(width: 6);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //!:
                                SizedBox(
                                  height: widget.recipe.diets!.isEmpty ? 0 : 25,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'Diets: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              fontSize: 14,
                                              color: Colors.grey.shade300,
                                            ),
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              widget.recipe.diets!.length,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              widget.recipe.diets![index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                            );
                                          },
                                          separatorBuilder: (_, index) {
                                            return const SizedBox(width: 6);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: keysList!.isEmpty ? 0 : 40,
                                  child: ListView.separated(
                                    separatorBuilder: (_, index) {
                                      return const SizedBox(width: 6);
                                    },
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: keysList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        elevation: 4,
                                        backgroundColor: Colors.white,
                                        label: Text(
                                          keysList![index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                color: kOrangeColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          SizedBox(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Servings  ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                        ),
                                        Text(
                                          '${widget.recipe.servings} pp',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Ready In  ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                        ),
                                        Text(
                                          '${widget.recipe.readyInMinutes}m',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ingredients",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (_, index) {
                                    return const SizedBox(height: 6);
                                  },
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: widget.recipe.ingredients!.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${widget.recipe.ingredients![index].name}',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nutritions",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  separatorBuilder: ((context, index) =>
                                      const SizedBox(height: 6)),
                                  itemCount: nutritionsList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text("${nutritionsList[index].name}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                        Text(
                                          "${nutritionsList[index].amount.toStringAsFixed(1)}${nutritionsList[index].unit}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ],
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: Colors.grey.shade700,
                            thickness: 1.1,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Instructions",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  separatorBuilder: ((context, index) =>
                                      const SizedBox(height: 6)),
                                  itemCount: widget
                                      .recipe.instructions![0].steps!.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      "${index + 1}- ${widget.recipe.instructions![0].steps![index].step}",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BottomSaveButton(
              saveRecipe: () {
                bookmark.insertRecipe(widget.recipe);
              },
            ),
          ],
        ),
      ),
    );
  }
}
