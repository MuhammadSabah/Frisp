import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/src/widgets/custom_drop_down.dart';
import 'package:food_recipe_final/src/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/src/screens/tabs/bookmark_tab.dart';
import 'package:food_recipe_final/src/screens/tabs/search_tab.dart';
import 'package:food_recipe_final/src/services/recipe_service.dart';
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
  // final ScrollController _scrollController = ScrollController();
  late TextEditingController _searchController;
  late TabController _tabController;
  List<String> _previousSearches = [];
  List<ResultsAPI> _currentSearches = [];
  int currentCount = 0;
  Future<RecipeAPIQuery>? _searchResult;

  Future<RecipeAPIQuery>? getRecipeData(String query, int number) async {
    final recipeJson = await RecipeService().getRecipes(query, number);
    if (recipeJson == null) {
      throw 'Data is null';
    }
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
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Search"),
                Tab(text: "Bookmarks"),
              ],
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
              indicatorColor: Colors.grey.shade600,
              // indicator: CircleTabIndicator(
              //   radius: 4.1,
              //   color: Colors.grey.shade600,
              // ),
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
                  SearchTab(
                    controller: _searchController,
                    currentSearches: _currentSearches,
                    count: currentCount,
                    futureMethod: _searchResult,
                  ),
                  const BookmarkTab(),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: InkWell(
                child: Ink(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                    color: kOrangeColorTint,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.tune_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      _searchResult = getRecipeData(
        _searchController.text.trim(),
        50,
      );
      _currentSearches.clear();
      currentCount = 0;
      value = value.trim();
      if (!_previousSearches.contains(value)) {
        _previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }
}
