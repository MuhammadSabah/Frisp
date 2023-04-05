import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/app_theme.dart';
import 'package:food_recipe_final/firebase_options.dart';
import 'package:food_recipe_final/localization/localization.dart';
import 'package:food_recipe_final/main.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/log_in_form.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/sign_up_form.dart';
import 'package:food_recipe_final/src/features/bookmark_recipe/repository/bookmark_interface.dart';
import 'package:food_recipe_final/src/features/splash/screens/splash_screen.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';
import 'package:food_recipe_final/src/navigation/route_generator.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/bookmark_provider.dart';
import 'package:food_recipe_final/src/providers/message_provider.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/shopping_provider.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // HttpOverrides.global = null;
    await Hive.initFlutter();
    Hive.registerAdapter(ShoppingItemAdapter());
    await Hive.openBox<ShoppingItem>('shoppingItems');
    onboardingBox = await Hive.openBox('onboarding');
  });
  Widget createApp() {
    return MultiProvider(
      providers: [
        Provider<BookmarkInterface>(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          lazy: false,
          create: (context) => MessageProvider(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
        ),
        ChangeNotifierProvider<UserProvider>(
          lazy: false,
          create: (context) => UserProvider(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
        ),
        ChangeNotifierProvider<UserImageProvider>(
          create: (context) => UserImageProvider(
            FirebaseAuth.instance,
            FirebaseStorage.instance,
          ),
        ),
        ChangeNotifierProvider<RecipePostProvider>(
          lazy: false,
          create: (context) => RecipePostProvider(
            FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => ShoppingProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => SettingsProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsManager, _) {
          ThemeData theme;
          if (settingsManager.darkMode) {
            theme = AppTheme.dark();
          } else {
            theme = AppTheme.light();
          }
          return GetMaterialApp(
            supportedLocales: Localization.all,
            debugShowCheckedModeBanner: false,
            theme: theme,
            initialRoute: AppPages.splashPath,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }

  Future<void> navigateToOnboardingThenSignupScreen(WidgetTester tester) async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('page1')), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('page2')), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('page3')), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('SignupWithEmailButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('SignupWithEmailButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signup-form')), findsOneWidget);

    await tester.pumpAndSettle();
  }

  testWidgets(
      'MyApp should build and the Onboarding screen should navigate to the next tab on tapping the "Next" button until the Welcome Screen and then tap on the "signup with email" button and proceed to the Signup Screen',
      (WidgetTester tester) async {
    await navigateToOnboardingThenSignupScreen(tester);
  });

  testWidgets('Successful signup', (WidgetTester tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('SignupWithEmailButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('SignupWithEmailButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signup-form')), findsOneWidget);

    await tester.pumpAndSettle();
    final signUpForm = find.byType(SignupForm);

    final signUpFormWidget = tester.widget(signUpForm) as SignupForm;
    final userNameController = signUpFormWidget.userNameController;
    final emailController = signUpFormWidget.emailController;
    final passwordController = signUpFormWidget.passwordController;
    final timeBasedEmail = '${DateTime.now().microsecondsSinceEpoch}@test.com';

    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == userNameController),
        'test_user');
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == emailController),
        timeBasedEmail);
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == passwordController),
        'test_password');

    await tester.tap(find.byKey(const Key("sign-up-button")));
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('loginButton')), findsOneWidget);
    await tester.pumpAndSettle();
  });
  testWidgets(
      'Failed sign up because of email is incorrect and the password in less than 6 characters',
      (WidgetTester tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('SignupWithEmailButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('SignupWithEmailButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signup-form')), findsOneWidget);

    await tester.pumpAndSettle();
    final signUpForm = find.byType(SignupForm);
    final signUpFormWidget = tester.widget(signUpForm) as SignupForm;
    final userNameController = signUpFormWidget.userNameController;
    final emailController = signUpFormWidget.emailController;
    final passwordController = signUpFormWidget.passwordController;
    final timeBasedEmail = '${DateTime.now().microsecondsSinceEpoch}test.com';

    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == userNameController),
        'test_user');
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == emailController),
        timeBasedEmail);
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == passwordController),
        '112');

    await tester.tap(find.byKey(const Key("sign-up-button")));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Error'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(FirebaseAuth.instance.currentUser, isNull);
    await tester.pumpAndSettle();
  });
  // //!: Login tests
  testWidgets('Failed login because of email is not registered',
      (WidgetTester tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('LoginWithAccountButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('LoginWithAccountButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('loginForm')), findsOneWidget);

    await tester.pumpAndSettle();
    final logInForm = find.byType(LoginForm);

    final logInFormWidget = tester.widget(logInForm) as LoginForm;
    final emailController = logInFormWidget.emailController;
    final passwordController = logInFormWidget.passwordController;
    final timeBasedEmail = '${DateTime.now().microsecondsSinceEpoch}test.com';

    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == emailController),
        timeBasedEmail);
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == passwordController),
        'test_password');

    await tester.tap(find.byKey(const Key("loginButton")));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Error'), findsOneWidget);
    await tester.pumpAndSettle();
  });
  testWidgets('Successful login', (WidgetTester tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('LoginWithAccountButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('LoginWithAccountButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('loginForm')), findsOneWidget);

    await tester.pumpAndSettle();
    final logInForm = find.byType(LoginForm);

    final logInFormWidget = tester.widget(logInForm) as LoginForm;
    final emailController = logInFormWidget.emailController;
    final passwordController = logInFormWidget.passwordController;

    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == emailController),
        "test@example.com");
    await tester.enterText(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.controller == passwordController),
        'test_password');

    await tester.tap(find.byKey(const Key("loginButton")));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    expect(find.byKey(const Key('home-screen')), findsWidgets);
    await tester.pumpAndSettle();
  });
  testWidgets('Like a post and comment ', (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('likeButton')).first);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('commentButton')).first);
    await tester.pumpAndSettle();

    final textFieldFinder = find.byKey(const Key('commentField')).first;
    await tester.enterText(textFieldFinder, 'Hello, world!');
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('sendCommentButton')).first);
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Hello, world!'), findsWidgets);
    await tester.pumpAndSettle();
  });

  testWidgets('Search for user', (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('searchUserIconButton')));
    await tester.pumpAndSettle();

    final textFieldFinder = find.byKey(const Key('searchUserTextField'));
    await tester.enterText(textFieldFinder, 'hama');
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('userSearchResultList')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('ProfileScreen')), findsOneWidget);
    await tester.pumpAndSettle();
  });

  // testWidgets('Edit user profile information', (tester) async {
  //   await tester.pumpWidget(createApp());
  //   await tester.pumpAndSettle();

  //   expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
  //   await tester.tap(find.byTooltip('Profile'));
  //   await tester.pumpAndSettle();
  //   await tester.pump(const Duration(seconds: 2));

  //   await tester.tap(find.byKey(const Key('editProfileButton')));
  //   await tester.pumpAndSettle();
  //   // expect(find.byKey(const Key('editProfileScreen')), findsOneWidget);

  //   // final userNameTextFieldFinder =
  //   //     find.byKey(const Key('usernameTextField')).first;
  //   // await tester.enterText(userNameTextFieldFinder, 'Hama Sabah');
  //   // await tester.pumpAndSettle();

  //   // final bioTextFieldFinder = find.byKey(const Key('bioTextField')).first;
  //   // await tester.enterText(bioTextFieldFinder, 'I love cooking!');
  //   // await tester.pumpAndSettle();

  //   // await tester.tap(find.byKey(const Key('saveButton')));
  //   // await tester.pumpAndSettle();
  // });

  testWidgets('Change application theme to dark mode', (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('profileSettingsButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settingsScreen')), findsOneWidget);

    await tester.tap(find.byKey(const Key('darkModeSwitch')));
    await tester.pumpAndSettle();

    expect(((tester.firstWidget(find.text('Settings')) as Text).style)?.color,
        Colors.black);
    await tester.pumpAndSettle();
  });

  testWidgets('Send a message to another user', (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('profileSendMessageButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('chatMessagesScreen')), findsOneWidget);

    final messageTextFieldFinder =
        find.byKey(const Key('chatMessagesScreen_textField')).first;
    await tester.enterText(messageTextFieldFinder, 'ONE PIECE');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('chatMessagesScreen_sendButton')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('ONE PIECE'), findsWidgets);
    await tester.pumpAndSettle();
  });

  testWidgets('Search a food recipe and then view to see more detail',
      (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
    await tester.tap(find.byTooltip('Search Recipe'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    final textFieldFinder = find.byKey(const Key('searchTextField'));
    await tester.enterText(textFieldFinder, 'chocolate');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('searchButton')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byKey(const Key('recipeCard')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('RecipeDetailScreen')), findsOneWidget);
    await tester.pumpAndSettle();
  });
  testWidgets(
      'Search for a food and view to see more detail and then tap the save button to save the recipe to the bookmarks list',
      (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
    await tester.tap(find.byTooltip('Search Recipe'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    final textFieldFinder = find.byKey(const Key('searchTextField'));
    await tester.enterText(textFieldFinder, 'chocolate');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('searchButton')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byKey(const Key('recipeCard')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('RecipeDetailScreen')), findsOneWidget);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('saveRecipeButton')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("bookmark tab")));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("bookmark_card")), findsWidgets);
    await tester.pumpAndSettle();
  });

  testWidgets('Add a shopping item to the shopping list', (tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomNavigationBar')), findsOneWidget);
    await tester.tap(find.byTooltip('Shopping List'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('addShoppingItemButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('shoppingItemScreen')), findsOneWidget);
    await tester.pumpAndSettle();

    final nameFieldFinder = find.byKey(const Key('nameTextField'));
    await tester.enterText(nameFieldFinder, '1kg of rice');
    await tester.pumpAndSettle();

    final quantityFieldFinder = find.byKey(const Key('quantityField'));
    await tester.enterText(quantityFieldFinder, '20');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('shoppingItemScreen_saveButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('shoppingScreen')), findsOneWidget);
    expect(find.text('1kg of rice'), findsWidgets);
    await tester.pumpAndSettle();
  });
}
