import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/discover_tab.dart';
import 'package:food_recipe_final/src/view/screens/feed_screen/tab_bars/activity_tab.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                          const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80'),
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
                  
                  children: [
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
