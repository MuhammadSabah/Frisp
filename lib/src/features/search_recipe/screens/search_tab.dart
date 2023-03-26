import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_final/src/features/search_recipe/widgets/recipe_grid_view.dart';
import 'package:food_recipe_final/src/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    Provider.of<SettingsProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 292;
    super.build(context);
    if (widget.controller.text.length < 3) {
      return SizedBox(
        height: 300,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
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
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return FutureBuilder<RecipeAPIQuery>(
      future: widget.futureMethod,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final query = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Shimmer.fromColors(
                  // enabled: true,
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          );
        } else if (query.results.length == 0) {
          return Center(
              child: Text(
            "Recipe is not available, try another one.",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ));
        } else if (snapshot.data == null) {
          return Center(
              child: Text(
            "Data is not available!",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ));
        } else {
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
