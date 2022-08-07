import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/app_theme.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/widgets/auth_confirm_button.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.signupPath,
      key: ValueKey(AppPages.signupPath),
      child: const SignUpScreen(),
    );
  }

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height / 40,
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.grey.shade500,
            size: 21,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Sign up',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 34),
                ),
                const SizedBox(height: 50),
                // !: Username Field
                Container(
                  decoration: const BoxDecoration(
                      // color: kGreyColor,
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Username Required';
                      } else if (_userNameController.text.length < 4) {
                        return 'Username should be at least 4 characters';
                      } else if (_userNameController.text.length > 16) {
                        return 'Username is too long!';
                      }
                      return null;
                    },
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    controller: _userNameController,
                    cursorColor: Colors.white,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counterText: ' ',
                      fillColor: kGreyColor,
                      filled: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(18),
                      hintText: '@Username',
                      hintStyle:
                          Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                      focusedErrorBorder: kFocusedErrorBorder,
                      errorBorder: kErrorBorder,
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      border: kBorder,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // !: Email field
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Required';
                      }
                      return null;
                    },
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    controller: _emailController,
                    cursorColor: Colors.white,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counterText: ' ',
                      fillColor: kGreyColor,
                      filled: true,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(18),
                      hintText: 'Your Email',
                      hintStyle:
                          Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                      focusedErrorBorder: kFocusedErrorBorder,
                      errorBorder: kErrorBorder,
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      border: kBorder,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // !: Password field
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Required';
                      }
                      return null;
                    },
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    controller: _passwordController,
                    cursorColor: Colors.white,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counterText: ' ',
                      fillColor: kGreyColor,
                      filled: true,
                      isCollapsed: true,
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: _obscureText
                                ? FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.grey.shade400,
                                    size: 20,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.grey.shade400,
                                    size: 20,
                                  ),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.all(18),
                      hintText: 'Password',
                      hintStyle:
                          Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                      focusedErrorBorder: kFocusedErrorBorder,
                      errorBorder: kErrorBorder,
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      border: kBorder,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'By signing up you agree to our Terms of Use and Privacy Policy',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                AuthConfirmButton(
                  title: 'Sign up',
                  callBack: () async {
                    final isValidForm = _formKey.currentState!.validate();
                    if (isValidForm) {
                      final _output = await Provider.of<AppStateManager>(
                              context,
                              listen: false)
                          .signUpUser(
                        userName: _userNameController.text,
                        userEmail: _emailController.text,
                        userPassword: _passwordController.text,
                      );
                      if (_output != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$_output'),
                          duration: const Duration(
                            milliseconds: 2300,
                          ),
                          backgroundColor: Colors.red.shade500,
                        ));
                      }
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                AuthBottomRichText(
                  detailText: 'Already have account? ',
                  clickableText: 'Log in',
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const LogInScreen()),
                    // );
                    Provider.of<AppStateManager>(context, listen: false)
                        .goToLogIn();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
