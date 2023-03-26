import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/main.dart';
import 'package:food_recipe_final/src/features/onboarding/pages/page_1.dart';
import 'package:food_recipe_final/src/features/onboarding/pages/page_2.dart';
import 'package:food_recipe_final/src/features/onboarding/pages/page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  onLastPage = (value == 2) ? true : false;
                });
              },
              children: const [
                Page1(
                  key: Key('page1'),
                ),
                Page2(
                  key: Key('page2'),
                ),
                Page3(
                  key: Key('page3'),
                ),
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: WormEffect(
                          type: WormType.normal,
                          // scale: 1.5,
                          dotHeight: 12,
                          dotWidth: 12,
                          dotColor: Colors.grey.shade300,
                          activeDotColor: kOrangeColor,
                          // activePaintStyle: PaintingStyle.stroke,
                          strokeWidth: 2,
                          spacing: 12,
                        ),
                        onDotClicked: (index) {
                          // ctnIndex = index;
                        },
                      ),
                    ),
                  ),
                  onLastPage
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                //! Go to auth screen.
                                onboardingBox?.put(1, true);
                                Navigator.pushNamed(context, AppPages.auth);
                              },
                              child: const Text('Done'),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text('Next'),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
