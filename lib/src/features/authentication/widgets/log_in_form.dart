import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';

import 'package:food_recipe_final/src/features/authentication/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/auth_confirm_button.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    AuthProvider appState = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0).copyWith(top: 8),
            child: Form(
              key: widget.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log in',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 34),
                    ),
                    const SizedBox(height: 50),
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
                        controller: widget.emailController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        // controller: _nameController,
                        cursorColor: kOrangeColor,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,

                        obscureText: false,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          counterText: ' ',
                          fillColor: settingsManager.darkMode
                              ? kGreyColor
                              : kGreyColor4,
                          filled: true,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'Your Email',
                          hintStyle:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                        controller: widget.passwordController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        // controller: _nameController,
                        cursorColor: kOrangeColor,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          counterText: ' ',
                          fillColor: settingsManager.darkMode
                              ? kGreyColor
                              : kGreyColor4,
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
                                        color: settingsManager.darkMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade800,
                                        size: 20,
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.eye,
                                        color: settingsManager.darkMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade800,
                                        size: 20,
                                      ),
                              ),
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'Your Password',
                          hintStyle:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          text: 'Forget Password?',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, AppPages.forgetPasswordPath,
                                  arguments: true);
                            },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthConfirmButton(
                      key: const Key('loginButton'),
                      title: 'Log in',
                      callBack: () async {
                        final navigator = Navigator.of(context);
                        FocusManager.instance.primaryFocus?.unfocus();
                        final isValidForm =
                            widget.formKey.currentState!.validate();
                        if (isValidForm) {
                          setState(() {
                            _isLoading = true;
                          });
                          final output = await appState.logInUser(
                            userEmail: widget.emailController.text.trim(),
                            userPassword: widget.passwordController.text,
                          );
                          await userProvider.refreshUser();
                          if (output == null) {
                            navigator.pushReplacementNamed(AppPages.home);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          if (output != null) {
                            Get.snackbar(
                              'Error',
                              output,
                              snackPosition: SnackPosition.TOP,
                              forwardAnimationCurve: Curves.elasticInOut,
                              reverseAnimationCurve: Curves.easeOut,
                              colorText: settingsManager.darkMode
                                  ? Colors.white
                                  : Colors.black,
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                    AuthBottomRichText(
                      detailText: 'Don\'t have account? ',
                      clickableText: 'Sign up',
                      onTap: () {
                        Navigator.pushNamed(context, AppPages.signupPath);
                      },
                      darkColor: Colors.white54,
                      lightColor: Colors.grey.shade800,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _isLoading == true
              ? LinearProgressIndicator(
                  backgroundColor: settingsManager.darkMode
                      ? Colors.white
                      : Colors.grey.shade300,
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
        ),
      ],
    );
  }
}
