import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/screens/add_recipe_post_screen/add_recipe_post_screen.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/feed_screen.dart';
import 'package:food_recipe_final/src/view/screens/profile_screen.dart';
import 'package:food_recipe_final/src/view/screens/search_screen/search_recipe_screen.dart';
import 'package:food_recipe_final/src/view/screens/shopping_screen/shopping_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.home,
      key: ValueKey(AppPages.home),
      child: HomeScreen(
        currentTabIndex: currentTab,
      ),
    );
  }

  const HomeScreen({Key? key, required this.currentTabIndex}) : super(key: key);
  final int currentTabIndex;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Widget> pages = [
    FeedScreen(),
    const SearchRecipeScreen(),
    const AddRecipePostScreen(),
    const ShoppingScreen(),
    ProfileScreen(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    // SettingsScreen(),
  ];

  Future<void> getUserData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 2500), () {
      userProvider.refreshUser();
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (context, manager, child) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: IndexedStack(
            index: widget.currentTabIndex,
            children: pages,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                manager.gotToTab(index);
              },
              currentIndex: widget.currentTabIndex,
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
      );
    });
  }
}
