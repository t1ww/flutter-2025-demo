// Import testing utilities for Flutter and Bloc
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Import the cubit, model, and repository from the project
import 'package:flutter_weather_bloc/recipe_cubit.dart';
import 'package:flutter_weather_bloc/recipe_model.dart';
import 'package:flutter_weather_bloc/recipe_repository.dart';

// Import Mockito annotations and utilities for generating and using mocks
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the generated mocks file
import 'flutter_recipe_test.mocks.dart';

// Tell Mockito to generate a mock class for RecipeRepository
@GenerateMocks([RecipeRepository])
void main() {
  // Group all tests related to RecipeCubit
  group('RecipeCubut', () {
    // Declare mock repository and cubit variables
    late MockRecipeRepository mockRecipeRepo;
    late RecipeCubit recipeCubit;

    // Runs before each test to initialize fresh instances
    setUp(() {
      mockRecipeRepo = MockRecipeRepository();
      recipeCubit = RecipeCubit(mockRecipeRepo);
    });

    // Runs after each test to close the cubit and release resources
    tearDown(() {
      recipeCubit.close();
    });

    // Test case: successful recipe search
    // Expects the cubit to emit loading state first, then loaded state with recipe data
    blocTest<RecipeCubit, RecipeState>(
      'emits [RecipeLoading, RecipeLoaded] when search succeeds',
      build: () {
        // Mock repository behavior to return a recipe list when searching 'beef'
        when(mockRecipeRepo.searchByIngredient('beef')).thenAnswer(
          (_) async => [
            Recipe(
              title: 'Spaghetti',
              ingredients: ['pasta', 'tomato', 'beef'],
            ),
          ],
        );
        return recipeCubit;
      },
      // Action: trigger the search method on the cubit
      act: (recipeCubit) => recipeCubit.search('beef'),
      // Expected states emitted by the cubit
      expect: () => [
        RecipeLoading(),
        RecipeLoaded([
          Recipe(
            title: 'Spaghetti',
            ingredients: ['pasta', 'tomato', 'beef'],
          ),
        ]),
      ],
    );

    // Test case: recipe search fails (throws an exception)
    // Expects the cubit to emit loading state first, then an error state
    blocTest<RecipeCubit, RecipeState>(
      'emits [RecipeLoading, RecipeError] when search throws',
      build: () {
        // Mock repository behavior to throw an exception when searching 'beef'
        when(mockRecipeRepo.searchByIngredient('beef')).thenThrow(Exception('error'));
        return recipeCubit;
      },
      // Action: trigger the search method on the cubit
      act: (recipeCubit) => recipeCubit.search('beef'),
      // Expected states emitted by the cubit (error type is RecipeError)
      expect: () => [RecipeLoading(), isA<RecipeError>()],
    );
  });
}
