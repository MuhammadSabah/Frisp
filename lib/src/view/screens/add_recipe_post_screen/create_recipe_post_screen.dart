import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/recipe_post_provider.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/widgets/add_fields_section.dart';
import 'package:food_recipe_final/src/view/widgets/title_and_description_form_section.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateRecipePost extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.createPostRecipePath,
      key: ValueKey(AppPages.createPostRecipePath),
      child: const CreateRecipePost(),
    );
  }

  const CreateRecipePost({Key? key}) : super(key: key);

  @override
  State<CreateRecipePost> createState() => _CreateRecipePostState();
}

class _CreateRecipePostState extends State<CreateRecipePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _servesController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final _navigator = Navigator.of(context);
    setState(() {
      _isLoading = true;
    });

    try {
      //
      String? result = await RecipePostProvider().uploadRecipePost(
        uid: uid,
        userName: userName,
        userEmail: userEmail,
        imageFile: _imageFile!,
        profImage: profImage,
        title: _titleController.text,
        description: _descriptionController.text,
        serves: _servesController.text,
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
        _navigator.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
  void _selectAnImageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        final imageProvider =
            Provider.of<UserImageProvider>(context, listen: false);
        return SimpleDialog(
          backgroundColor: kGreyColor,
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
    _servesController.dispose();
    _cookTimeController.dispose();
    for (TextEditingController t in _ingredientControllersList) {
      t.dispose();
    }
    for (TextEditingController t in _instructionsControllersList) {
      t.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .createRecipePostClicked(false);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                      onTap: () {
                        //!: publish post.
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm && _imageFile != null) {
                          publishRecipePost(
                            uid: user!.id,
                            userName: user.userName,
                            userEmail: user.email,
                            profImage: user.photoUrl,
                          );
                        }
                      },
                      child: Ink(
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: const Center(
                          child: Text(
                            'Publish',
                            style: TextStyle(
                              color: kOrangeColor,
                            ),
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
                        highlightColor: Colors.grey.shade400,
                        onTap: () {
                          _selectAnImageDialog(context);
                        },
                        child: Ink(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: _imageFile == null
                                ? const DecorationImage(
                                    image: NetworkImage(''),
                                    fit: BoxFit.cover,
                                  )
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
                                          .headline2!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
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
                      formKey: _formKey,
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                      servesController: _servesController,
                      cookTimeController: _cookTimeController,
                    ),
                    const Divider(
                      color: kGreyColor,
                      thickness: 10,
                    ),
                    // !: Sections:
                    const SizedBox(height: 14),
                    AddFieldsSection(
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
                    const Divider(
                      color: kGreyColor,
                      thickness: 10,
                    ),
                    AddFieldsSection(
                      formFieldsList: _instructionsFormList,
                      controllersList: _instructionsControllersList,
                      popUpItemsList: _popUpItemsList,
                      buttonText: '+ Step',
                      validatorText: 'Field Required',
                      addButtonColor: Colors.white,
                      leadingTextFieldColor: Colors.white,
                      sectionText: 'Instructions',
                      hintText: 'Mix the flour and water until they thicken',
                      buttonTextColor: kBlackColor,
                      maxLines: 2,
                      leadingTextFieldTextColor: Colors.black,
                      cursorColor: Colors.white,
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
                    ? const LinearProgressIndicator()
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
