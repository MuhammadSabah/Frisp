import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/components/recipe_list.dart';
import 'package:food_recipe_final/models/api/recipe_api_model.dart';

class SearchTab extends StatefulWidget {
  SearchTab({
    Key? key,
    required this.controller,
    required this.currentSearches,
    required this.count,
    required this.futureMethod,
  }) : super(key: key);

  final TextEditingController controller;
  final List<ResultsAPI> currentSearches;
  final count;
  final Future<RecipeAPIQuery>? futureMethod;
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.length < 3) {
      return SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/search-outline.svg',
                color: kOrangeColor,
                width: 70,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Search for your favorite recipe!",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }
    return FutureBuilder<RecipeAPIQuery>(
      // key: ValueKey(),
      future: widget.futureMethod,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                // textScaleFactor: 1.3,
              ),
            );
          }
          final query = snapshot.data;

          if (query != null) {
            widget.currentSearches.addAll(query.results);
            // .where((e) => e.vegan == true).toList()
          }
          return RecipeList(context: context, results: widget.currentSearches);
        } else {
          if (widget.count == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RecipeList(
                context: context, results: widget.currentSearches);
          }
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
