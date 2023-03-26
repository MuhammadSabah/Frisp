import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePostSection extends StatefulWidget {
  const ProfilePostSection({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String? userId;
  @override
  State<ProfilePostSection> createState() => _ProfilePostSectionState();
}

class _ProfilePostSectionState extends State<ProfilePostSection> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamResult;
  @override
  void initState() {
    streamResult = FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.userId)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 256;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamResult,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error no data is being retrieved!'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Text(
              'User doesn\'t have any posts published!',
              style: TextStyle(
                color: Colors.white,
              ),
            ));
          } else if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14),
              itemBuilder: (context, index) {
                final RecipePostModel recipePost = RecipePostModel.fromSnapshot(
                  snapshot.data!.docs[index],
                );
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: recipePost.postUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.white.withOpacity(0.5),
                                                Colors.white.withOpacity(0.2),
                                              ],
                                              stops: const [0.0, 1.0],
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  recipePost.likes.length
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              recipePost.title,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text('User doesn\'t have any posts published!'),
            );
          }
        },
      ),
    );
  }
}
