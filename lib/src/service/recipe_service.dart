import 'package:http/http.dart';

const String apiKey = '0208f09758084d9096e419ede1dc3090';
const String apiUrl = 'https://api.spoonacular.com/recipes/complexSearch';

//!: SpoonacularAPI
class RecipeService {
  Future getData(String url) async {
    print('Calling url: $url');

    // Response and get() are from the HTTP package.
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getRecipes(String query, int number) async {
    final recipeData = await getData(
        '$apiUrl?query=$query&fillIngredients=true&apiKey=$apiKey&addRecipeNutrition=true&addRecipeInformation=true&instructionsRequired=true&number=$number');
    return recipeData;
  }
}









// !: EdamamAPI
// const String apiKey = '326910d2bb469528ee7b79dd6c19f79b';
// const String apiId = 'e9611a71';
// const String apiUrl = 'https://api.edamam.com';

// class RecipeService {
//   Future getData(String url) async {
//     print('Calling url: $url');

//     // Response and get() are from the HTTP package.
//     final response = await get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       print(response.statusCode);
//     }
//   }

//   Future<dynamic> getRecipes(String query, int from, int to) async {
//     final recipeData = await getData(
//         '$apiUrl/search?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
//     return recipeData;
//   }
// }
