import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/discover_tab.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/activity_tab.dart';
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
    getUserData();
  }

  Future<void> getUserData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 2500), () {
      userProvider.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Row(
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
                        unselectedLabelColor: Colors.white,
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
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.userGroup,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                          const SizedBox(width: 10),
                          user == null
                              ? CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey.shade300,
                                )
                              : SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(user.photoUrl),
                                          fit: BoxFit.cover,
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
      ),
    );
  }
}
