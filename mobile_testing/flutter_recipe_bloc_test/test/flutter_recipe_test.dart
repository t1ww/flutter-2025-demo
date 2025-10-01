import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_bloc/recipe_cubit.dart';
import 'package:flutter_weather_bloc/recipe_model.dart';
import 'package:flutter_weather_bloc/recipe_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_recipe_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  group('RecipeCubut', () {
    late MockRecipeRepository mockRecipeRepo;
    late RecipeCubit recipeCubit;

    setUp(() {
      mockRecipeRepo = MockRecipeRepository();
      recipeCubit = RecipeCubit(mockRecipeRepo);
    });

    tearDown(() {
      recipeCubit.close();
    });

    blocTest<RecipeCubit, RecipeState>(
      'emits [RecipeLoading, RecipeLoaded] when search succeeds',
      build: () {
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
      act: (recipeCubit) => recipeCubit.search('beef'),
      expect:
          () => [
            RecipeLoading(),
            RecipeLoaded([
              Recipe(
                title: 'Spaghetti',
                ingredients: ['pasta', 'tomato', 'beef'],
              ),
            ]),
          ],
    );

    blocTest<RecipeCubit, RecipeState>(
      'emits [WeatherLoading, WeatherError] when fetchWeather throws',
      build: () {
        when(
          mockRecipeRepo.searchByIngredient('beef'),
        ).thenThrow(Exception('error'));
        return recipeCubit;
      },
      act: (recipeECubit) => recipeCubit.search('beef'),
      expect: () => [RecipeLoading(), isA<RecipeError>()],
    );
  });
}
