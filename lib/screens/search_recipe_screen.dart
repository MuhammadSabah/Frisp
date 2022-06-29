import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/components/custom_drop_down.dart';
import 'package:food_recipe_final/components/recipe_card.dart';
import 'package:food_recipe_final/models/recipe_model.dart';
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
  List<Hits> _currentSearches = [];

  bool _loading = false;
  bool _inErrorState = false;
  bool _hasMore = false;
  bool _startSearch = false;
  //
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;

  Future<RecipeQuery> getRecipeData(String query, int from, int to) async {
    final recipeJson = await RecipeService().getRecipes(query, from, to);
    final recipeMap = convert.json.decode(recipeJson);
    return RecipeQuery.fromJson(recipeMap);
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
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (_hasMore &&
            currentEndPosition < currentCount &&
            !_loading &&
            !_inErrorState) {
          setState(() {
            _loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
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
          Container(
            child: TabBar(
              controller: _tabController,
              indicatorColor: kOrangeColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(text: "Search"),
                Tab(text: "Bookmarks"),
              ],
            ),
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
                  Container(),
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
      currentStartPosition = 0;
      currentEndPosition = pageCount;
      _hasMore = true;
      value = value.trim();
      if (!_previousSearches.contains(value)) {
        _previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildRecipeLoader(BuildContext context) {
    if (_searchController.text.length < 3) {
      return Container(
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
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      );
    }
    return FutureBuilder<RecipeQuery>(
      future: getRecipeData(
        _searchController.text.trim(),
        currentStartPosition,
        currentEndPosition,
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
          _inErrorState = false;
          final query = snapshot.data;

          if (query != null) {
            currentCount == query.count;
            _hasMore = query.more;
            _currentSearches.addAll(query.hits);
            if (query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
            // .where((e) => e.vegan == true).toList()
          }
          return _buildRecipeList(context, _currentSearches);
        } else {
          if (currentCount == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildRecipeList(context, _currentSearches);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext context, List<Hits> hits) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 280;
    return Expanded(
      child: GridView.builder(
        // controller: _scrollController,
        itemCount: hits.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
          print(hits[index].recipe);
          final hit = hits[index].recipe;
          return _buildRecipeCard(context, hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, List<Hits> hits, int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(topLevelContext, MaterialPageRoute(
      //     builder: (context) {
      //       return const RecipeDetails();
      //     },
      //   ));
      // },
      child: RecipeCard(recipe: recipe),
    );
  }
}
