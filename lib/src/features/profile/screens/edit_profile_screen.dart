import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/features/bookmark_recipe/widgets/bottom_save_button.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_cached_background_photo.dart';
import 'package:food_recipe_final/src/features/profile/widgets/profile_default_background_photo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? _imageFile;
  bool _isLoading = false;
  late final TextEditingController _userNameController;
  late final TextEditingController _aboutController;
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
                    if (mounted) {
                      setState(() {
                        _imageFile = l;
                      });
                    }
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
                    if (mounted) {
                      setState(() {
                        _imageFile = l;
                      });
                    }
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

//
  @override
  void initState() {
    _userNameController = TextEditingController(text: widget.user.userName);
    _aboutController = TextEditingController(text: widget.user.bio);
    super.initState();
  }

  Future<void> updateProfileInfo(BuildContext context) async {
    final imageProvider =
        Provider.of<UserImageProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    String? downloadUrl;
    if (_imageFile != null) {
      downloadUrl = await imageProvider.uploadAnImageToStorage(
          fileName: 'profilePictures', file: _imageFile!, isPost: false);
    }
    // await imageProvider.updateUserProfilePhoto(downloadUrl);
    await widget.user.reference!.update(
      {
        'photoUrl': downloadUrl ?? widget.user.photoUrl,
        'userName': _userNameController.text,
        'bio': _aboutController.text,
      },
    );
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Get.snackbar(
      '✅',
      'Updated Profile',
      snackPosition: SnackPosition.TOP,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
      colorText: settingsManager.darkMode ? Colors.white : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      key: const Key('editProfileScreen'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: settingsManager.darkMode ? Colors.white : Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          'Account',
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.more_horiz,
              color: settingsManager.darkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Theme(
          data: Theme.of(context).copyWith(useMaterial3: false),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 75,
                                child: widget.user.photoUrl == "" &&
                                        _imageFile == null
                                    ? const ProfileDefaultBackgroundPhoto()
                                    : _imageFile != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: MemoryImage(_imageFile!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : ProfileCachedBackgroundPhoto(
                                            user: widget.user,
                                          ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: GestureDetector(
                                onTap: () {
                                  _selectAnImageDialog(context);
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                      color: kOrangeColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      )),
                                  child: const Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                key: const Key('usernameTextField'),
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                controller: _userNameController,
                                cursorColor: kOrangeColor,
                                autofocus: false,
                                autocorrect: false,
                                keyboardType: TextInputType.text,
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
                                  hintText: '',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
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
                            ],
                          ),
                          const SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About',
                                style: Theme.of(context).textTheme.displaySmall!
                                  ..copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                key: const Key('bioTextField'),
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                    ),
                                controller: _aboutController,
                                cursorColor: kOrangeColor,
                                autofocus: false,
                                autocorrect: false,
                                keyboardType: TextInputType.text,
                                maxLines: 8,
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
                                  hintText: '',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
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
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 24),
                            child: BottomSaveButton(
                              key: const Key('saveButton'),
                              callBack: () async {
                                await updateProfileInfo(context).then((value) {
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
