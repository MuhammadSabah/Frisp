import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/view/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/view/widgets/auth_confirm_button.dart';
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
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log in',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 34),
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
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                // controller: _nameController,
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
                controller: widget.passwordController,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                // controller: _nameController,
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
                  hintText: 'Your Password',
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
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forget Password?',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
              ),
            ),
            const SizedBox(height: 40),
            AuthConfirmButton(
              title: 'Log in',
              callBack: () async {
                FocusScope.of(context).unfocus();
                final isValidForm = widget.formKey.currentState!.validate();
                if (isValidForm) {
                  final _output =
                      await Provider.of<AppStateManager>(context, listen: false)
                          .logInUser(
                    userEmail: widget.emailController.text.trim(),
                    userPassword: widget.passwordController.text,
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
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            AuthBottomRichText(
              detailText: 'Don\'t have account? ',
              clickableText: 'Sign up',
              onTap: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .goToSignUp();
              },
            ),
          ],
        ),
      ),
    );
  }
}
