import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/features/search_user/widgets/user_search_result_list.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:provider/provider.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _searchUserController = TextEditingController();
  String searchName = '';
  Future<QuerySnapshot<Map<String, dynamic>>>? futureResult;
  @override
  void initState() {
    super.initState();
    futureResult = FirebaseFirestore.instance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: _searchUserController.text)
        .get();
  }

  void updateSearchResult() async {
    futureResult = FirebaseFirestore.instance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: _searchUserController.text)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: settingsManager.darkMode ? Colors.white : Colors.black,
              size: 24,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Search User',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18),
          ),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (String value) {
                              setState(() {
                                searchName = value;
                                updateSearchResult();
                              });
                            },
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                            controller: _searchUserController,
                            cursorColor: settingsManager.darkMode
                                ? Colors.white
                                : Colors.black,
                            autofocus: false,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              fillColor: settingsManager.darkMode
                                  ? kGreyColor
                                  : kGreyColor4,
                              filled: true,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(18),
                              hintText: 'Search...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
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
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            if (_searchUserController.text.isNotEmpty) {
                              updateSearchResult();
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 40,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: settingsManager.darkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 20,
                                  color: settingsManager.darkMode
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: futureResult,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Connection Error!'),
                          );
                        }
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text('No Data'),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text('No data!'),
                          );
                        }
                        if (_searchUserController.text.isEmpty) {
                          return UserSearchResultList(
                            searchName: searchName,
                            snapshot: snapshot,
                          );
                        }
                        return UserSearchResultList(
                          searchName: searchName,
                          snapshot: snapshot,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
