import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/features/authentication/screens/forget_password_screen.dart';
import 'package:food_recipe_final/src/features/authentication/screens/log_in_screen.dart';
import 'package:food_recipe_final/src/features/authentication/screens/sign_up_screen.dart';
import 'package:food_recipe_final/src/features/bookmark_recipe/screens/recipe_detail_screen.dart';
import 'package:food_recipe_final/src/features/chat/screens/chat_messages_screen.dart';
import 'package:food_recipe_final/src/features/chat/screens/contacts_list_screen.dart';
import 'package:food_recipe_final/src/features/comment/screens/comments_screen.dart';
import 'package:food_recipe_final/src/features/create_recipe_post/screens/create_recipe_post_screen.dart';
import 'package:food_recipe_final/src/features/home/screens/home_screen.dart';
import 'package:food_recipe_final/src/features/profile/screens/edit_profile_screen.dart';
import 'package:food_recipe_final/src/features/profile/screens/followers_screen.dart';
import 'package:food_recipe_final/src/features/profile/screens/following_screen.dart';
import 'package:food_recipe_final/src/features/profile/screens/profile_screen.dart';
import 'package:food_recipe_final/src/features/recipe_feed/widgets/recipe_post_detail_screen.dart';
import 'package:food_recipe_final/src/features/search_user/screens/search_user_screen.dart';
import 'package:food_recipe_final/src/features/settings/screens/settings_screen.dart';
import 'package:food_recipe_final/src/features/shopping/screens/shopping_item_screen.dart';
import 'package:food_recipe_final/src/features/splash/screens/splash_screen.dart';
import 'package:food_recipe_final/src/features/welcome/screens/welcome_screen.dart';
import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:food_recipe_final/src/models/user_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppPages.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppPages.splashPath:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppPages.signupPath:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case AppPages.loginPath:
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );
      case AppPages.profilePath:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            userId: args as String,
          ),
        );
      case AppPages.commentsPath:
        return MaterialPageRoute(
          builder: (context) => CommentsScreen(
            recipePost: args as RecipePostModel,
          ),
        );
      case AppPages.createPostRecipePath:
        return MaterialPageRoute(
          builder: (context) => const CreateRecipePostScreen(),
        );
      case AppPages.editProfilePath:
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            user: args as UserModel,
          ),
        );
      case AppPages.auth:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case AppPages.welcomePath:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case AppPages.postDetails:
        return MaterialPageRoute(
          builder: (context) => RecipePostDetailScreen(
            recipePost: args as RecipePostModel,
          ),
        );
      case AppPages.shoppingItemDetails:
        return MaterialPageRoute(
          builder: (context) => const ShoppingItemScreen(),
        );
      case AppPages.recipeDetails:
        return MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(
            recipe: args as RecipeModel,
          ),
        );
      case AppPages.contactsPath:
        return MaterialPageRoute(
          builder: (context) => ContactsListScreen(),
        );
      case AppPages.chatPath:
        return MaterialPageRoute(
          builder: (context) => ChatMessagesScreen(
            user: args as UserModel,
          ),
        );
      case AppPages.settingsPath:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
      case AppPages.searchUserPath:
        return MaterialPageRoute(
          builder: (context) => const SearchUserScreen(),
        );
      case AppPages.recipePostDetails:
        return MaterialPageRoute(
          builder: (context) => RecipePostDetailScreen(
            recipePost: args as RecipePostModel,
          ),
        );
      case AppPages.forgetPasswordPath:
        return MaterialPageRoute(
          builder: (context) => ForgetPasswordScreen(
            isForget: args as bool,
          ),
        );
      case AppPages.followersPath:
        return MaterialPageRoute(
          builder: (context) => FollowersScreen(user: args as UserModel),
        );
      case AppPages.followingPath:
        return MaterialPageRoute(
          builder: (context) => FollowingScreen(user: args as UserModel),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: ((context) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Page not found'),
            ),
          )),
    );
  }
}
