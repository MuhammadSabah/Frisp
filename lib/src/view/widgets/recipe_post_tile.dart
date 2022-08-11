import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';

class RecipePostTile extends StatelessWidget {
  const RecipePostTile({Key? key, required this.onCommentPressed})
      : super(key: key);
  final Function()? onCommentPressed;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      // height: screenHeight / 1.8,
      decoration: BoxDecoration(
          color: kGreyColor2,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.grey.shade800,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User image and user name section.
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth - (screenWidth - 15),
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 8,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/flower.jpg'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'User Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'User Email',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
            //The post description.
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 12,
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'sdfak sdfkj sdfk skdf ksdjf sudifoe dshjsd hasdjfhj 90944r sdjkafjlksd0 93493 dksajkfl 9pi  sadfjlsd klsajdfkjs 9994 jsadk jjjfsl jksadf ;adjf hasdfh iadifo i893899 isajfk ioasjlif ja sfkadj jaksdfjka kjsda o9oe 9o ja fla jkjdkjkjf jla f;a l klad f930 jdfl',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            //Image container or card.
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.grey.withOpacity(0.1),
                      child: Stack(
                        children: [
                          Container(
                            height: screenHeight / 3,
                            width: screenWidth - 24,
                            decoration: const BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/flower.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              // 3.2 is the image height.
                              height: (screenHeight / 3.2) / 3.4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Title',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color: kBlackColor,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Subtitle',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                          color: Colors
                                                              .grey.shade600),
                                                ),
                                              ),
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
                        ],
                      ),
                    ),
                  ],
                ),
                // Likes and other interactions:
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: 8,
                  ),
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '2 Likes',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.thumb_up_outlined,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: onCommentPressed,
                                icon: Icon(
                                  Icons.comment,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.share_outlined,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
