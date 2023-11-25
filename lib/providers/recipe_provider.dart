import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier() : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();
    
    // for debugging purposes
    /*for (var doc in snapshot.docs) {
      print('Log: Recipes from firestore - ${doc.id}: ${doc.data()}');
    }*/
    
    final recipes = snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
        .toList();
    state = recipes;
  }

  void addRecipe(String recipeName, List<String> ingredients,
      List<String> recipeSteps, String category) async {
    final recipeData = Recipe(
            recipeId: '',
            recipeName: recipeName,
            ingredients: ingredients,
            recipeSteps: recipeSteps,
            picture: "Placeholder",
            category: category)
        .toFirestore();

    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final recipe = Recipe.fromFirestore(recipeData, recipeRef.id);
    state = [...state, recipe];
  }

  void deleteRecipe(String recipeId) {
    _firestore.collection('recipes').doc(recipeId).delete().then((_) {
      state = state.where((recipe) => recipe.recipeId != recipeId).toList();
      print("success!");
    }).catchError((error) {
      print("Failed to delete recipe: $error");
    });
  }
}

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>(
    (ref) => RecipeNotifier());
