import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  bool isLoading = false;
  ByteData? _defaultImage;

  void selectAnImage(BuildContext context) async {
    final result = await Provider.of<StorageMethods>(context, listen: false)
        .pickAnImage(ImageSource.gallery);

    result.fold((l) {
      setState(() {
        _image = l;
      });
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(r.toString()),
          duration: const Duration(
            milliseconds: 2300,
          ),
          backgroundColor: kGreyColor,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/default_image.jpg').then(
          (data) => _defaultImage = data,
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 256;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  _image != null
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 3.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/default_image.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    left: 5,
                    top: 0,
                    child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        selectAnImage(context);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: Colors.grey.shade300,
                        size: 21,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Provider.of<AppStateManager>(context, listen: false)
                            .settingsClicked(true);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.gear,
                        color: Colors.grey.shade300,
                        size: 21,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.2,
                        decoration: const BoxDecoration(
                          color: kGreyColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Cooking Mama',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10),
                                child: Text(
                                  'Delightful homemade tasty healthy recipes for your family',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 110,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Follow',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              color: kGreyColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Recipes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text('128'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Followers',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text('210k'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Following',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text('12'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Posts Section:
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          'Post Title',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
