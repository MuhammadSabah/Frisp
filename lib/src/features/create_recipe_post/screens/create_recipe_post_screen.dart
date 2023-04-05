import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/features/create_recipe_post/widgets/add_fields_section.dart';
import 'package:food_recipe_final/src/features/recipe_feed/widgets/title_and_description_form_section.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateRecipePostScreen extends StatefulWidget {
  const CreateRecipePostScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipePostScreen> createState() => _CreateRecipePostScreenState();
}

class _CreateRecipePostScreenState extends State<CreateRecipePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? servesValue;

  final List<String> _popUpItemsList = ['Delete item', 'Add item'];
  final List _ingredientsFormList = [];
  final List _instructionsFormList = [];
  final List<TextEditingController> _ingredientControllersList = [];
  final List<TextEditingController> _instructionsControllersList = [];
  bool _isLoading = false;

  //
  Uint8List? _imageFile;
  //
  Future<void> publishRecipePost({
    required String uid,
    required String userName,
    required String userEmail,
    required String profImage,
  }) async {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    setState(() {
      _isLoading = true;
    });

    try {
      //
      String? result = await RecipePostProvider(
        FirebaseFirestore.instance,
      ).uploadRecipePost(
        uid: uid,
        userName: userName,
        userEmail: userEmail,
        imageFile: _imageFile!,
        profImage: profImage,
        title: _titleController.text,
        description: _descriptionController.text,
        serves: servesValue ?? '',
        cookTime: _cookTimeController.text,
        ingredients: _ingredientControllersList.map((element) {
          return element.text;
        }).toList(),
        steps: _instructionsControllersList.map((e) => e.text).toList(),
      );
      if (result == null) {
        setState(() {
          _isLoading = false;
        });
        navigator.pop();
      }
      FocusManager.instance.primaryFocus?.unfocus();
      Get.snackbar(
        '✅',
        'Post Published',
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        colorText: settingsManager.darkMode ? Colors.white : Colors.black,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  void _selectAnImageDialog(BuildContext context) async {
    () => FocusManager.instance.primaryFocus?.unfocus();
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        final imageProvider =
            Provider.of<UserImageProvider>(context, listen: false);
        return SimpleDialog(
          backgroundColor: settingsManager.darkMode ? kGreyColor : Colors.white,
          title: const Center(
            child: Text(
              'Select an Image',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          children: [
            SimpleDialogOption(
                child: const Text(
                  'Take a photo',
                  style: TextStyle(
                    color: kOrangeColor,
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final result =
                      await imageProvider.pickAnImage(ImageSource.camera);

                  result.fold((l) {
                    setState(() {
                      _imageFile = l;
                    });
                  }, (r) {
                    // Do nothing.
                    debugPrint(result.toString());
                  });
                }),
            SimpleDialogOption(
                child: const Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    color: kOrangeColor,
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final result =
                      await imageProvider.pickAnImage(ImageSource.gallery);

                  result.fold((l) {
                    setState(() {
                      _imageFile = l;
                    });
                  }, (r) {
                    // Do nothing.
                    debugPrint(result.toString());
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 0),
              child: SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _cookTimeController.dispose();
    for (TextEditingController t in _ingredientControllersList) {
      t.dispose();
    }
    for (TextEditingController t in _instructionsControllersList) {
      t.dispose();
    }
  }

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);
    UserModel? user;
    if (userProvider.getUser != null) {
      user = userProvider.getUser;
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          useMaterial3: false,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Create',
              style:
                  Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
            ),
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: settingsManager.darkMode ? Colors.white : Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    elevation: 4,
                    child: InkWell(
                      key: const Key('publishButton'),
                      onTap: () {
                        //!: publish post.
                        final isValidForm = _formKey.currentState!.validate();
                        final isValidForm1 = _formKey1.currentState!.validate();
                        final isValidForm2 = _formKey2.currentState!.validate();
                        if (isValidForm &&
                            _imageFile != null &&
                            isValidForm1 &&
                            isValidForm2) {
                          publishRecipePost(
                            uid: user!.id,
                            userName: user.userName,
                            userEmail: user.email,
                            profImage: user.photoUrl,
                          );
                        }
                      },
                      child: Ink(
                        width: 95,
                        decoration: BoxDecoration(
                            color: settingsManager.darkMode
                                ? Colors.white
                                : kOrangeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            'Publish',
                            style: TextStyle(
                                color: settingsManager.darkMode
                                    ? kOrangeColor
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      child: InkWell(
                        key: const Key('uploadImage'),
                        highlightColor: Colors.grey.shade400,
                        onTap: () {
                          _selectAnImageDialog(context);
                        },
                        child: Ink(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: _imageFile == null
                                ? null
                                : DecorationImage(
                                    image: MemoryImage(_imageFile!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.camera,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Upload a recipe photo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            color: settingsManager.darkMode
                                                ? Colors.white
                                                : Colors.grey.shade800,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // !: Title and Description Section:
                    TitleAndDescriptionFormSection(
                      onChanged: (value) {
                        setState(() {
                          servesValue = value as String;
                        });
                      },
                      formKey: _formKey,
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                      servesValue: servesValue,
                      cookTimeController: _cookTimeController,
                    ),
                    Divider(
                      color: settingsManager.darkMode
                          ? kGreyColor
                          : Colors.grey.shade300,
                      thickness: 10,
                    ),
                    // !: Sections:
                    const SizedBox(height: 14),
                    AddFieldsSection(
                      formKey: _formKey1,
                      formFieldsList: _ingredientsFormList,
                      controllersList: _ingredientControllersList,
                      popUpItemsList: _popUpItemsList,
                      buttonText: '+ Ingredient',
                      validatorText: 'Field Required',
                      addButtonColor: kOrangeColor,
                      leadingTextFieldColor: kOrangeColor,
                      sectionText: 'Ingredients',
                      hintText: '250g flour',
                      buttonTextColor: Colors.white,
                      maxLines: 1,
                      leadingTextFieldTextColor: Colors.white,
                      cursorColor: kOrangeColor,
                    ),
                    Divider(
                      color: settingsManager.darkMode
                          ? kGreyColor
                          : Colors.grey.shade300,
                      thickness: 10,
                    ),
                    AddFieldsSection(
                      formKey: _formKey2,
                      formFieldsList: _instructionsFormList,
                      controllersList: _instructionsControllersList,
                      popUpItemsList: _popUpItemsList,
                      buttonText: '+ Step',
                      validatorText: 'Field Required',
                      addButtonColor: settingsManager.darkMode
                          ? Colors.white
                          : Colors.black,
                      leadingTextFieldColor: settingsManager.darkMode
                          ? Colors.white
                          : Colors.black,
                      sectionText: 'Steps',
                      hintText: 'Mix the flour and water until they thicken',
                      buttonTextColor:
                          settingsManager.darkMode ? kBlackColor : Colors.white,
                      maxLines: 2,
                      leadingTextFieldTextColor: settingsManager.darkMode
                          ? Colors.black
                          : Colors.white,
                      cursorColor: settingsManager.darkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                    const SizedBox(height: 120),
                  ],
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
      ),
    );
  }
}
