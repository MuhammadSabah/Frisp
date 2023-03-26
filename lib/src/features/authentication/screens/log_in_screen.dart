import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/features/authentication/widgets/log_in_form.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pushNamed(context, AppPages.signupPath);
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.grey.shade500,
              size: 21,
            ),
          ),
        ),
        body: LoginForm(
          key: const ValueKey('loginForm'),
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}
