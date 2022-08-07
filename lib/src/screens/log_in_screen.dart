import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/app_theme.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/widgets/auth_confirm_button.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.loginPath,
      key: ValueKey(AppPages.loginPath),
      child: const LogInScreen(),
    );
  }

  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
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
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false).goToSignUp();
          },
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log in',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                      final isValidForm = _formKey.currentState!.validate();
                      if (isValidForm) {
                        final _output = await Provider.of<AppStateManager>(
                                context,
                                listen: false)
                            .logInUser(
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
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  AuthBottomRichText(
                    detailText: 'Don\'t have account? ',
                    clickableText: 'Sign up',
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const SignUpScreen()),
                      // );
                      Provider.of<AppStateManager>(context, listen: false)
                          .goToSignUp();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
