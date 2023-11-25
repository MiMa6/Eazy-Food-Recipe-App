import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/widgets/recipe_tiles.dart';
import '../providers/recipe_provider.dart';
import '../components/text_and_color.dart';

class RecipeListCategory extends ConsumerWidget {
  final String categoryName;

  const RecipeListCategory({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);

    final recipesByCategory =
        recipes.where((recipe) => recipe.category == categoryName).toList();

    return ListView.builder(
      itemCount: recipesByCategory.length,
      itemBuilder: (context, index) {
        return RecipeTile(recipe: recipesByCategory[index]);
      },
    );
  }
}

class RecipeListSearch extends ConsumerWidget {
  final String searchPattern;

  const RecipeListSearch({super.key, required this.searchPattern});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);

    final recipesBsearchCategory = recipes
        .where((recipe) => recipe.recipeName
            .toLowerCase()
            .contains(searchPattern.toLowerCase()))
        .toList();

    if (recipesBsearchCategory.isEmpty) {
      return Center(
          child: Text(
        "No recipes found by '$searchPattern'",
        style: menuSubTitleTextStyle,
      ));
    }
    return ListView.builder(
      itemCount: recipesBsearchCategory.length,
      itemBuilder: (context, index) {
        return RecipeTile(recipe: recipesBsearchCategory[index]);
      },
    );
  }
}
