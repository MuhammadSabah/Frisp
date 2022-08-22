// import 'package:flutter/material.dart';
// import 'package:food_recipe_final/src/models/recipe_post_model.dart';
// import 'package:food_recipe_final/src/view/widgets/instructions_section.dart';

// // ignore: must_be_immutable
// class RecipePostDetailScreen extends StatefulWidget {
//   RecipePostDetailScreen({
//     Key? key,
//     required this.recipePost,
//   }) : super(key: key);
//   RecipePostModel recipePost;
//   @override
//   State<RecipePostDetailScreen> createState() => _RecipePostDetailScreenState();
// }

// class _RecipePostDetailScreenState extends State<RecipePostDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(useMaterial3: false),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             CustomScrollView(
//               slivers: [
//                 DetailsSliverAppBar(
//                   imgUrl: widget.recipe.image ?? "",
//                   title: widget.recipe.title ?? '',
//                 ),
//                 SliverToBoxAdapter(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           DetailsTitleSection(
//                             diets: widget.recipe.diets ?? [],
//                             dishTypes: widget.recipe.dishTypes ?? [],
//                             sourceName: widget.recipe.creditsText ?? '',
//                             sourceUrl: widget.recipe.sourceUrl ?? '',
//                             keysList: keysList ?? [],
//                             title: widget.recipe.title ?? '',
//                           ),
//                           Divider(
//                             color: Colors.grey.shade700,
//                             thickness: 1.1,
//                           ),
//                           ServingsAndReadyInSection(
//                             readyInMinutes: widget.recipe.readyInMinutes!,
//                             servings: widget.recipe.servings!,
//                           ),
//                           Divider(
//                             color: Colors.grey.shade700,
//                             thickness: 1.1,
//                           ),
//                           const SizedBox(height: 16),
//                           IngredientsSection(
//                             ingredients: widget.recipe.ingredients!,
//                           ),
//                           const SizedBox(height: 16),
//                           Divider(
//                             color: Colors.grey.shade700,
//                             thickness: 1.1,
//                           ),
//                           const SizedBox(height: 16),
//                           NutritionsSection(
//                             nutritionsList: nutritionsList,
//                           ),
//                           const SizedBox(height: 16),
//                           Divider(
//                             color: Colors.grey.shade700,
//                             thickness: 1.1,
//                           ),
//                           const SizedBox(height: 16),
//                           InstructionsSection(
//                             instructions: widget.recipe.instructions,
//                           ),
//                           const SizedBox(height: 60),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
