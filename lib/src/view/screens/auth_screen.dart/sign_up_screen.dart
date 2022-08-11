import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/view/widgets/auth_bottom_rich_text.dart';
import 'package:food_recipe_final/src/view/widgets/auth_confirm_button.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/view/widgets/sign_up_form.dart';
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
          child: SignupForm(
            formKey: _formKey,
            userNameController: _userNameController,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ),
    );
  }
}
