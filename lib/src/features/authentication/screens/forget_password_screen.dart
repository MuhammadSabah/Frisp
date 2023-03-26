import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key, required this.isForget})
      : super(key: key);
  final bool isForget;
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider appState = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          bottomOpacity: 0.0,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.grey.shade500,
              size: 21,
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              // height: MediaQuery.of(context).size.height / 1.5,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        widget.isForget
                            ? 'Forget Password?'
                            : 'Change Password.',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 32),
                      ),
                      const SizedBox(height: 26),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text:
                              'Please enter your registered email address. An email notification with a password reset link will then be sent to you.',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: settingsManager.darkMode
                                        ? Colors.white54
                                        : Colors.black,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 24),
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
                          style:
                              Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          cursorColor: settingsManager.darkMode
                              ? Colors.white
                              : Colors.black,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: settingsManager.darkMode
                              ? Colors.white
                              : Colors.black,
                          elevation: 4,
                          child: InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final isValidForm =
                                  formKey.currentState!.validate();
                              if (isValidForm) {
                                setState(() {
                                  _isLoading = true;
                                });
                                final output = await appState.forgetPassword(
                                  email: _emailController.text.trim(),
                                );
                                if (output == null) {
                                  Get.snackbar(
                                    'Successful',
                                    'Email sent!',
                                    snackPosition: SnackPosition.TOP,
                                    forwardAnimationCurve: Curves.elasticInOut,
                                    reverseAnimationCurve: Curves.easeOut,
                                    colorText: settingsManager.darkMode
                                        ? Colors.white
                                        : Colors.black,
                                  );
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
                            child: Ink(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Send Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: settingsManager.darkMode
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 7),
                    ],
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
        ),
      ),
    );
  }
}
