import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/shopping_manager.dart';
import 'package:food_recipe_final/src/view/screens/add_recipe_post_screen/create_recipe_post_screen.dart';
import 'package:food_recipe_final/src/view/screens/comments_screen/comments_screen.dart';
import 'package:food_recipe_final/src/view/screens/home_screen.dart';
import 'package:food_recipe_final/src/view/screens/auth_screen/log_in_screen.dart';
import 'package:food_recipe_final/src/view/screens/settings_screen.dart';
import 'package:food_recipe_final/src/view/screens/auth_screen/sign_up_screen.dart';
import 'package:food_recipe_final/src/view/screens/shopping_screen/shopping_item_screen.dart';
import 'package:food_recipe_final/src/view/screens/splash_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final ShoppingManager shoppingManager;

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
        ] else if (!appStateManager.isSignedUp) ...[
          SignUpScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LogInScreen.page(),
        ] else if (appStateManager.isLoggedIn &&
            appStateManager.isSignedUp) ...[
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
          if (appStateManager.isSettingsClicked) SettingsScreen.page(),
          if (appStateManager.isCommentsClicked) CommentsScreen.page(),
          if (appStateManager.didCreateRecipePost) CreateRecipePost.page(),
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
    if (route.settings.name == AppPages.settingsPath) {
      appStateManager.settingsClicked(false);
    }
    if (route.settings.name == AppPages.commentsPath) {
      appStateManager.commentsClicked(false);
    }
    if (route.settings.name == AppPages.createPostRecipePath) {
      appStateManager.createRecipePostClicked(false);
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
