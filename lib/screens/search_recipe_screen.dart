import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/components/custom_drop_down.dart';
import 'package:food_recipe_final/components/recipe_card.dart';
import 'package:food_recipe_final/components/recipe_list.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:food_recipe_final/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/screens/recipe_detail_screen.dart';
import 'package:food_recipe_final/screens/tabs/bookmark_tab.dart';
import 'package:food_recipe_final/service/recipe_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({Key? key}) : super(key: key);

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen>
    with SingleTickerProviderStateMixin {
  static const prefSearchKey = 'previousSearches';
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _searchController;
  late TabController _tabController;
  List<String> _previousSearches = [];
  List<ResultsAPI> _currentSearches = [];

  bool _loading = false;
  int currentCount = 0;

  Future<RecipeAPIQuery> getRecipeData(String query, int number) async {
    final recipeJson = await RecipeService().getRecipes(query, number);
    final recipeMap = convert.json.decode(recipeJson);
    return RecipeAPIQuery.fromJson(recipeMap);
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, _previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        _previousSearches = searches;
      } else {
        _previousSearches = [];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController(text: '');
    getPreviousSearches();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildSearchCard(),
          TabBar(
            controller: _tabController,
            indicatorColor: kOrangeColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            tabs: const [
              Tab(text: "Search"),
              Tab(text: "Bookmarks"),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: double.maxFinite,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRecipeLoader(context),
                  BookmarkTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 4,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 20,
              onPressed: () {
                startSearch(_searchController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      cursorColor: const Color(0xffF94701),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      autocorrect: false,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        if (!_previousSearches.contains(value)) {
                          _previousSearches.add(value);
                          savePreviousSearches();
                        }
                      },
                    ),
                  ),
                  PopupMenuButton(
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onSelected: (String value) {
                      _searchController.text = value;
                      startSearch(_searchController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return _previousSearches
                          .map<CustomDropDownMenu<String>>(
                            (String value) => CustomDropDownMenu(
                              value: value,
                              text: value,
                              callback: () {
                                setState(
                                  () {
                                    _previousSearches.remove(value);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      _currentSearches.clear();
      currentCount = 0;

      // _hasMore = true;
      value = value.trim();
      if (!_previousSearches.contains(value)) {
        _previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildRecipeLoader(BuildContext context) {
    if (_searchController.text.length < 3) {
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
      future: getRecipeData(
        _searchController.text.trim(),
        30,
      ),
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
          _loading = false;
          final query = snapshot.data;

          if (query != null) {
            _currentSearches.addAll(query.results);
            // .where((e) => e.vegan == true).toList()
          }
          return RecipeList(context: context, results: _currentSearches);
        } else {
          if (currentCount == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RecipeList(context: context, results: _currentSearches);
          }
        }
      },
    );
  }
}
