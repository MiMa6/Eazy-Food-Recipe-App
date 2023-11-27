import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/widgets/recipe_tiles.dart';
import '../providers/recipe_provider.dart';
import '../providers/user_provider.dart';
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

class RecipeListFavorite extends ConsumerWidget {

  const RecipeListFavorite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final recipes = ref.watch(recipeProvider);
    final asyncUser = ref.watch(userProvider);

    return asyncUser.when(
      data: (user) {
        if (user != null) {
          final recipesByFavorite = recipes
              .where((recipe) => recipe.favouriteUserIds.contains(user.uid))
              .toList();
          if (recipesByFavorite.isEmpty) {
            return Center(
                child: Text(
              "No recipes added to favorites yet",
              style: menuSubTitleTextStyle,
            ));
          } else {
            return ListView.builder(
              itemCount: recipesByFavorite.length,
              itemBuilder: (context, index) {
                return RecipeTile(recipe: recipesByFavorite[index]);
              },
            );
          }
        } else {
          return const Center(child: Text("Login to add favorite recipes"));
        }
      },
      error: (error, stackTrace) {
        return const Center(child: Text("Something went wrong.."));
      },
      loading: () {
        return const Center(child: Text("Loading..."));
      },
    );
  }
}
