import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/features/bookmark_recipe/screens/bookmark_tab.dart';
import 'package:food_recipe_final/src/features/search_recipe/screens/search_tab.dart';
import 'package:food_recipe_final/src/features/search_recipe/widgets/custom_drop_down.dart';
import 'package:food_recipe_final/src/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/services/recipe_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
  final List<ResultsAPI> _currentSearches = [];
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(useMaterial3: false),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
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
                          labelStyle:
                              Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 14,
                                  ),
                          tabs: const [
                            Tab(text: "Search"),
                            Tab(key: Key("bookmark tab"),text: "Bookmarks"),
                          ],
                          indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          indicatorColor: settingsManager.darkMode
                              ? Colors.grey.shade700
                              : Colors.black,
                          unselectedLabelColor: settingsManager.darkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                          labelColor: settingsManager.darkMode
                              ? Colors.white
                              : Colors.black,
                          // indicator: CircleTabIndicator(
                          //   radius: 4.1,
                          //   color: Colors.grey.shade600,
                          // ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 6),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: settingsManager.darkMode ? Colors.white : kGreyColor4,
              elevation: 2,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              key: const Key('searchTextField'),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                              controller: _searchController,
                              cursorColor: const Color(0xffF94701),
                              decoration: InputDecoration(
                                hintText: 'Chocolate, pasta, pizza etc...',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                              autocorrect: false,
                              autofocus: false,
                              onSubmitted: (value) {
                                if (!_previousSearches.contains(value) &&
                                    value.isNotEmpty &&
                                    value != " ") {
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
                                      isRemovable: true,
                                      callback: () {
                                        setState(
                                          () {
                                            FocusScope.of(context).unfocus();
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
          ),
          const SizedBox(width: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: kOrangeColorTint,
              child: InkWell(
                key: const Key('searchButton'),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  startSearch(_searchController.text);
                },
                child: Ink(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
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
        30,
      );
      _currentSearches.clear();
      currentCount = 0;
      value = value.trim();
      if (!_previousSearches.contains(value) &&
          value.isNotEmpty &&
          value != '' &&
          value != ' ') {
        FocusScope.of(context).unfocus();
        _previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }
}
