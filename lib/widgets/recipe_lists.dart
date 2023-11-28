import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/widgets/recipe_tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

import '../providers/recipe_provider.dart';
import '../providers/user_provider.dart';
import '../components/text_and_color.dart';
import '../models/recipe.dart';

class RecipeListByCategorySmooth extends ConsumerWidget {
  final String categoryName;
  const RecipeListByCategorySmooth({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesQuery = FirebaseFirestore.instance
        .collection('recipes')
        .where('category', isEqualTo: categoryName)
        .orderBy('recipeName');

    return FutureBuilder<QuerySnapshot>(
      future: recipesQuery.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: (categoryName == "")
                  ? const Text("")
                  : Text("No recipes found by '$categoryName'",
                      style: menuSubTitleTextStyle));
        } else {
          return FirestoreListView<Map<String, dynamic>>(
            pageSize: 20,
            query: recipesQuery,
            itemBuilder: (context, snapshot) {
              final recipe = Recipe.fromFirestore(snapshot.data(), snapshot.id);
              return RecipeTile(recipe: recipe);
            },
          );
        }
      },
    );
  }
}

class RecipeListByFavorite extends ConsumerWidget {
  const RecipeListByFavorite({super.key});

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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Log in to create recipes and add favorites',
                    style: menuSubTitleTextStyle),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Login'),
                  onPressed: () async {
                    context.go('/login');
                  },
                ),
              ],
            ),
          );
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

class RecipeListBySearch extends ConsumerWidget {
  final String searchPattern;

  const RecipeListBySearch({super.key, required this.searchPattern});

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
