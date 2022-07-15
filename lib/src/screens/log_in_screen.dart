import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/app_pages.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/src/components/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/components/auth_confirm_button.dart';
import 'package:food_recipe_final/src/models/app_state_manager.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.loginPath,
      key: ValueKey(AppPages.loginPath),
      child: const LogInScreen(),
    );
  }

  const LogInScreen({Key? key}) : super(key: key);

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
          child: Container(
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
                _buildEmailOrPassField(context, true, 'Your Email'),
                const SizedBox(height: 20),
                _buildEmailOrPassField(context, false, 'Password'),
                const SizedBox(height: 10),
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
                  callBack: () {
                    Provider.of<AppStateManager>(context, listen: false)
                        .logIn('email', 'password');
                  },
                ),
                const Spacer(),
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
    );
  }

  Container _buildEmailOrPassField(
      BuildContext context, bool isEmail, String hintText) {
    return Container(
      decoration: const BoxDecoration(
          color: kGreyColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        // controller: _nameController,
        cursorColor: Colors.white,
        autofocus: false,
        autocorrect: false,
        keyboardType: isEmail == true ? TextInputType.emailAddress : null,
        obscureText: isEmail == false ? true : false,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          isCollapsed: true,
          suffixIcon: isEmail == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.eye,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                    ),
                  ],
                )
              : null,
          contentPadding: const EdgeInsets.all(18),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 15,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
