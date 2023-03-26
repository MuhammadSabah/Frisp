import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe_final/src/models/data_class_models/recipe_model.dart';
import 'package:food_recipe_final/src/providers/bookmark_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockRecipeModel extends Mock implements RecipeModel {}

void main() {
  late BookmarkProvider bookmarkProvider;

  setUp(() {
    bookmarkProvider = BookmarkProvider();
  });

  group('watchAllRecipes', () {
    test('returns a stream of recipes', () {
      final recipes = [
        MockRecipeModel(),
        MockRecipeModel(),
      ];

      expect(bookmarkProvider.watchAllRecipes(), emits(recipes));
      recipes.forEach(bookmarkProvider.insertRecipe);
    });
  });

  group('insertRecipe', () {
    test('adds a recipe to the stream', () {
      final recipe = MockRecipeModel();

      expect(bookmarkProvider.watchAllRecipes(), emits([recipe]));
      bookmarkProvider.insertRecipe(recipe);
    });
  });

  group('deleteRecipe', () {
    test('removes a recipe from the stream', () {
      final recipe = MockRecipeModel();
      bookmarkProvider.insertRecipe(recipe);

      expect(bookmarkProvider.watchAllRecipes(), emits([]));
      bookmarkProvider.deleteRecipe(recipe);
    });
  });
}
