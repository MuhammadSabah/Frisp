import 'package:http/http.dart';

const String apiKey = 'ecaffca6a7227bdf12e1029042e715f7';
const String apiId = '8af5a35e';
const String apiUrl = 'https://api.edamam.com';

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

  Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
        '$apiUrl/search?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    return recipeData;
  }
}
