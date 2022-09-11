import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/features/create_recipe_post/screens/add_recipe_post_screen.dart';
import 'package:food_recipe_final/src/features/recipe_feed/screens/feed_screen.dart';
import 'package:food_recipe_final/src/features/profile/screens/profile_screen.dart';
import 'package:food_recipe_final/src/features/search_recipe/screens/search_recipe_screen.dart';
import 'package:food_recipe_final/src/features/shopping/screens/shopping_screen.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
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

    await userProvider.refreshUser().whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
        : Consumer<AuthProvider>(
            builder: (context, manager, child) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Scaffold(
                    extendBody: false,
                    resizeToAvoidBottomInset: false,
                    body: IndexedStack(
                      index: manager.selectedTab,
                      children: pages,
                    ),
                    bottomNavigationBar: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: BottomNavigationBar(
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          onTap: (index) {
                            manager.gotToTab(index);
                          },
                          currentIndex: manager.selectedTab,
                          type: BottomNavigationBarType.fixed,
                          iconSize: 20,
                          items: const [
                            BottomNavigationBarItem(
                              icon: FaIcon(
                                FontAwesomeIcons.house,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: FaIcon(
                                FontAwesomeIcons.plus,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: FaIcon(
                                FontAwesomeIcons.clipboardList,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: FaIcon(
                                FontAwesomeIcons.solidUser,
                              ),
                              label: '',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
