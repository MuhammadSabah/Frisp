import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
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
  bool _isLoading = false;

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.refreshUser().whenComplete(
          () => setState(() {
            _isLoading = false;
          }),
        );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  static User? auth = FirebaseAuth.instance.currentUser;
  List<Widget> pages = [
    const FeedScreen(),
    const SearchRecipeScreen(),
    const AddRecipePostScreen(),
    const ShoppingScreen(),
    ProfileScreen(
      userId: auth?.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Consumer<AppStateManager>(builder: (context, manager, child) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: IndexedStack(
                  index: widget.currentTabIndex,
                  children: pages,
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
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
                          size: 22,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 22,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 22,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesomeIcons.clipboardList,
                          size: 22,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: 22,
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
