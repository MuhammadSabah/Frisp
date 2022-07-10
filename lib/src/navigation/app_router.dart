import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/app_state_manager.dart';
import 'package:food_recipe_final/src/screens/home_screen.dart';
import 'package:food_recipe_final/src/screens/splash_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    appStateManager.removeListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      // onPopPage: ,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else ...[
          HomeScreen.page(appStateManager.selectedTab),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
