import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/features/recipe_feed/screens/discover_tab.dart';
import 'package:food_recipe_final/src/features/recipe_feed/screens/activity_tab.dart';
import 'package:food_recipe_final/src/providers/auth_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).getUser;
    final appProvider = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);

    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        extendBody: true,
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
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                              tabs: const [
                                Tab(text: 'Activity'),
                                Tab(text: 'Discover'),
                              ],
                              indicatorPadding:
                                  const EdgeInsets.only(right: 10),
                              labelColor: kOrangeColorTint,
                              unselectedLabelColor: settingsManager.darkMode
                                  ? Colors.white
                                  : kGreyColor3,
                              indicatorColor: kOrangeColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                key: const Key('searchUserIconButton'),
                                splashRadius: 20,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPages.searchUserPath,
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
                                key: const Key('profileIconButton'),
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
                                                child: CachedNetworkImage(
                                                  imageUrl: user.photoUrl,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Center(
                                                    child: FaIcon(
                                                        FontAwesomeIcons
                                                            .circleExclamation),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade400,
                                                    highlightColor:
                                                        Colors.grey.shade300,
                                                    child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3.3,
                                                        width: double.infinity),
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
                        children: [
                          ActivityTab(user: user),
                          const DiscoverTab(),
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
