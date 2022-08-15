import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/models/recipe_post_model.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePostSection extends StatefulWidget {
  const ProfilePostSection({Key? key}) : super(key: key);

  @override
  State<ProfilePostSection> createState() => _ProfilePostSectionState();
}

class _ProfilePostSectionState extends State<ProfilePostSection> {
  Future<QuerySnapshot<Map<String, dynamic>>>? futureResult;

  @override
  void initState() {
    super.initState();
    futureResult = FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 256;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
      child: FutureBuilder<Object>(
        future: futureResult,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error no data is being retrieved!'),
            );
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
                              child: CachedNetworkImage(
                                imageUrl: recipePost.postUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade300,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        3.3,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              recipePost.title,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline3,
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
              child: Text(' '),
            );
          }
        },
      ),
    );
  }
}
