import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/auth_confirm_button.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.userNameController,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  final TextEditingController userNameController;
  final TextEditingController emailController;

  final TextEditingController passwordController;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          } else if (widget.userNameController.text.length <
                              4) {
                            return 'Username should be at least 4 characters';
                          } else if (widget.userNameController.text.length >
                              16) {
                            return 'Username is too long!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        controller: widget.userNameController,
                        cursorColor: kOrangeColor,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
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
                              fontWeight: FontWeight.w600,
                            ),
                        controller: widget.emailController,
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
                              fontWeight: FontWeight.w600,
                            ),
                        controller: widget.passwordController,
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
                                  if (mounted) {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }
                                },
                                icon: _obscureText
                                    ? FaIcon(
                                        FontAwesomeIcons.eyeSlash,
                                        color: settingsManager.darkMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade800,
                                        size: 18,
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.eye,
                                        color: settingsManager.darkMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade800,
                                        size: 18,
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
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'By signing up you agree to our Terms of Use and Privacy Policy',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    height: 1.6,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthConfirmButton(
                      title: 'Sign up',
                      callBack: () async {
                        final navigator = Navigator.of(context);
                        FocusManager.instance.primaryFocus?.unfocus();
                        final isValidForm =
                            widget.formKey.currentState!.validate();
                        if (isValidForm) {
                          if (mounted) {
                            setState(() {
                              _isLoading = true;
                            });
                          }
                          final output = await Provider.of<AuthProvider>(
                                  context,
                                  listen: false)
                              .signUpUser(
                            userName: widget.userNameController.text,
                            userEmail: widget.emailController.text.trim(),
                            userPassword: widget.passwordController.text,
                          );
                          if (output == null) {
                            FirebaseAuth.instance.signOut();
                            navigator.pushNamed(AppPages.loginPath);
                          }
                          if (mounted) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
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
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    AuthBottomRichText(
                      detailText: 'Already have account? ',
                      darkColor: Colors.white54,
                      clickableText: 'Log in',
                      lightColor: Colors.grey.shade800,
                      onTap: () {
                        Navigator.pushNamed(context, AppPages.loginPath);
                      },
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
