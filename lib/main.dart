import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/src/data/bookmark_manager.dart';
import 'package:food_recipe_final/src/models/app_state_manager.dart';
import 'package:food_recipe_final/src/screens/discover_screen.dart';
import 'package:food_recipe_final/src/screens/search_recipe_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static List<Widget> pages = [
    DiscoverScreen(),
    SearchRecipeScreen(),
  ];
  final _appStateManager = AppStateManager();
  final _bookmarkManager = BookmarkManager();

  int currentTab = 1;
  ThemeData theme = AppTheme.dark();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => _bookmarkManager,
        ),
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // extendBody: true,
          body: IndexedStack(
            index: currentTab,
            children: pages,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  currentTab = index;
                });
              },
              currentIndex: currentTab,
              type: BottomNavigationBarType.fixed,
              iconSize: 28,
              items: const [
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    size: 24,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 24,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 24,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.clipboardList,
                    size: 24,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 23,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
