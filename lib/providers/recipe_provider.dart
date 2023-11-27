import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/user_provider.dart';
import '../models/recipe.dart';

// TODO: pagination queries
class RecipeNotifier extends StateNotifier<List<Recipe>> {
  final String userId;
  DocumentSnapshot? lastDocument;

  RecipeNotifier({required this.userId}) : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();

    // for debugging purposes
    //for (var doc in snapshot.docs) {
    //  print('Log: Recipes from firestore - ${doc.id}: ${doc.data()}');
    //}

    final recipes = snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
        .toList();

    if (!mounted) return;
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
        category: category,
        userId: userId,
        favouriteUserIds: [""]).toFirestore();

    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final recipe = Recipe.fromFirestore(recipeData, recipeRef.id);
    state = [...state, recipe];
  }

  void addFavourite(String recipeId, String favouriteUserId) async {
    _firestore.collection('recipes').doc(recipeId).update({
      'favouriteUserIds': FieldValue.arrayUnion([favouriteUserId])
    }).then((_) {
      state = state
          .map((recipe) => recipe.recipeId == recipeId
              ? recipe.copyWith(favouriteUserIds: [
                  ...recipe.favouriteUserIds,
                  favouriteUserId
                ])
              : recipe)
          .toList();
      print("success added!");
    }).catchError((error) {
      print("Failed to add favourite: $error");
    });
  }

  void delFavourite(String recipeId, String favouriteUserId) async {
    _firestore.collection('recipes').doc(recipeId).update({
      'favouriteUserIds': FieldValue.arrayRemove([favouriteUserId])
    }).then((_) {
      state = state
          .map((recipe) => recipe.recipeId == recipeId
              ? recipe.copyWith(
                  favouriteUserIds: recipe.favouriteUserIds
                      .where((userId) => userId != favouriteUserId)
                      .toList())
              : recipe)
          .toList();
      print("success deleted!");
    }).catchError((error) {
      print("Failed to add favourite: $error");
    });
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

final recipeProvider =
    StateNotifierProvider<RecipeNotifier, List<Recipe>>((ref) {
  final asyncUser = ref.watch(userProvider);

  return asyncUser.when(data: (user) {
    return RecipeNotifier(userId: user?.uid ?? 'everyone');
  }, loading: () {
    return RecipeNotifier(userId: 'everyone');
  }, error: (error, stackTrace) {
    return RecipeNotifier(userId: 'everyone');
  });
});
