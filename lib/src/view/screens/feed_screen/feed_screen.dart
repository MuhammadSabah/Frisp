import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/discover_tab.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/activity_tab.dart';
import 'package:food_recipe_final/src/view/screens/search_user_screen.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // getUserData();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;
    final appProvider = Provider.of<AppStateManager>(context);
    final settingsManager = Provider.of<SettingsManager>(context,listen: false);

    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TabBar(
                            controller: _tabController,
                            labelStyle:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: 16,
                                    ),
                            tabs: const [
                              Tab(text: 'Activity'),
                              Tab(text: 'Discover'),
                            ],
                            indicatorPadding: const EdgeInsets.only(right: 10),
                            labelColor: kOrangeColorTint,
                            unselectedLabelColor: settingsManager.darkMode
                                ? Colors.white
                                : kGreyColor3,
                            indicatorColor: kOrangeColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchUserScreen(),
                                    ),
                                  );
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.userGroup,
                                  color: settingsManager.darkMode
                                      ? Colors.white
                                      : kGreyColor3,
                                  size: 21,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  appProvider.gotToTab(4);
                                },
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: user == null
                                      ? const Center(
                                          child: LinearProgressIndicator(
                                            color: kOrangeColor,
                                            backgroundColor: Colors.white,
                                          ),
                                        )
                                      : user.photoUrl == ""
                                          ? SizedBox(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/default_image.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          user.photoUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: SizedBox(
                      height: double.maxFinite,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          ActivityTab(),
                          DiscoverTab(),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
