import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_final/src/components/recipe_grid_view.dart';
import 'package:food_recipe_final/src/models/api/recipe_api_model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({
    Key? key,
    required this.controller,
    required this.currentSearches,
    required this.count,
    required this.futureMethod,
  }) : super(key: key);

  final TextEditingController controller;
  final List<ResultsAPI> currentSearches;
  final int count;
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AspectRatio(
                  aspectRatio: 2 / 1.2,
                  child: SvgPicture.asset('assets/searching.svg'),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Search for your favorite recipe!",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    return FutureBuilder<RecipeAPIQuery>(
      // key: ValueKey(),
      future: widget.futureMethod,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              textAlign: TextAlign.center,
            ),
          );
        } else if (snapshot.data == null) {
          return const Text("Data IS NULL");
        } else {
          final query = snapshot.data;
          if (query != null) {
            widget.currentSearches.addAll(query.results);
            // .where((e) => e.vegan == true).toList()
          }
          return RecipeGridView(
              context: context, results: widget.currentSearches);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
