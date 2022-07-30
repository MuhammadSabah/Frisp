import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/shopping_manager.dart';
import 'package:food_recipe_final/src/screens/home_screen.dart';
import 'package:food_recipe_final/src/screens/log_in_screen.dart';
import 'package:food_recipe_final/src/screens/shopping_item_screen.dart';
import 'package:food_recipe_final/src/screens/sign_up_screen.dart';
import 'package:food_recipe_final/src/screens/splash_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final ShoppingManager shoppingManager;
  final _auth = FirebaseAuth.instance;

  AppRouter({
    required this.appStateManager,
    required this.shoppingManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    shoppingManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    appStateManager.removeListener(notifyListeners);
    shoppingManager.removeListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isSignedUp &&
            _auth.currentUser == null) ...[
          SignUpScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LogInScreen.page(),
        ] else if (_auth.currentUser != null) ...[
          HomeScreen.page(appStateManager.selectedTab),
          if (shoppingManager.isCreatingNewItem)
            ShoppingItemScreen.page(
              onCreate: (item) {
                shoppingManager.addItem(item);
              },
              onUpdate: (item, index) {},
            ),
          if (shoppingManager.selectedIndex != -1)
            ShoppingItemScreen.page(
              item: shoppingManager.selectedShoppingItem,
              index: shoppingManager.selectedIndex,
              onCreate: (_) {},
              onUpdate: (item, index) {
                shoppingManager.updateItem(item, index);
              },
            ),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name == AppPages.onboardingPath) {
      appStateManager.logOutUser();
    }
    if (route.settings.name == AppPages.shoppingItemDetails) {
      shoppingManager.shoppingItemTapped(-1);
    }
    if (route.settings.name == AppPages.loginPath) {
      appStateManager.goToSignUp();
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
