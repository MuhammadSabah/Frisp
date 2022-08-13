import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/view/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/view/widgets/auth_confirm_button.dart';
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
  ByteData? _imageData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign up',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 34),
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
                  } else if (widget.userNameController.text.length < 4) {
                    return 'Username should be at least 4 characters';
                  } else if (widget.userNameController.text.length > 16) {
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
                  hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
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
                  hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
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
                  hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
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
                FocusScope.of(context).unfocus();
                final isValidForm = widget.formKey.currentState!.validate();
                if (isValidForm) {
                  setState(() {
                    _isLoading = true;
                  });
                  final output =
                      await Provider.of<AppStateManager>(context, listen: false)
                          .signUpUser(
                    userName: widget.userNameController.text,
                    userEmail: widget.emailController.text,
                    userPassword: widget.passwordController.text,
                    // photoUrl: 'assets/default_image.jpg',
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  if (output != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('$output'),
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
                Provider.of<AppStateManager>(context, listen: false)
                    .goToLogIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
