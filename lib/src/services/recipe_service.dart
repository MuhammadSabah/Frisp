import 'package:food_recipe_final/creds.dart';
import 'package:http/http.dart';

// const String apiKey = <Your API key>;
const String apiUrl = 'https://api.spoonacular.com/recipes/complexSearch';

//!: SpoonacularAPI
class RecipeService {
  Future getData(String url) async {
    // Response and get() are from the HTTP package.
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else {
      // print("STATUS CODE: $response.statusCode");
      return Future.value();
    }
  }

  Future<dynamic> getRecipes(String query, int number) async {
    final recipeData = await getData(
        '$apiUrl?query=$query&fillIngredients=true&apiKey=$apiKey&addRecipeNutrition=true&addRecipeInformation=true&instructionsRequired=true&number=$number');
    if (recipeData != null) {
      return Future.value(recipeData);
    } else {
      return Future.value();
    }
  }
}

