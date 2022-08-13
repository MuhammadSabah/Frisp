import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/src/view/widgets/log_in_form.dart';
import 'package:provider/provider.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';

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
            child: LoginForm(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ),
        ),
      ),
    );
  }
}
