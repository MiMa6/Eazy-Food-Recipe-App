import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String recipeId;
  String recipeName;
  List<String> ingredients;
  List<String> recipeSteps;
  String picture;
  String category;
  String userId;
  List<String> favouriteUserIds;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.ingredients,
    required this.recipeSteps,
    required this.picture,
    required this.category,
    required this.userId,
    required this.favouriteUserIds,
  });

  Recipe copyWith({
    String? recipeId,
    String? recipeName,
    List<String>? ingredients,
    List<String>? recipeSteps,
    String? picture,
    String? category,
    String? userId,
    List<String>? favouriteUserIds,
  }) {
    return Recipe(
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      ingredients: ingredients ?? this.ingredients,
      recipeSteps: recipeSteps ?? this.recipeSteps,
      picture: picture ?? this.picture,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      favouriteUserIds: favouriteUserIds ?? this.favouriteUserIds,
    );
  }

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      recipeId: id,
      recipeName: data['recipeName'],
      ingredients: List<String>.from(data['ingredients']),
      recipeSteps: List<String>.from(data['recipeSteps']),
      picture: data['picture'],
      category: data['category'],
      userId: data['userId'],
      favouriteUserIds: List<String>.from(data['favouriteUserIds']),
    );
  }
  factory Recipe.fromDocument(DocumentSnapshot doc, String id) {
    return Recipe(
      recipeId: id,
      recipeName: doc['recipeName'],
      ingredients: List<String>.from(doc['ingredients']),
      recipeSteps: List<String>.from(doc['recipeSteps']),
      picture: doc['picture'],
      category: doc['category'],
      userId: doc['userId'],
      favouriteUserIds: List<String>.from(doc['favouriteUserIds']),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'recipeName': recipeName,
      'ingredients': ingredients,
      'recipeSteps': recipeSteps,
      'picture': picture,
      'category': category,
      'userId': userId,
      'favouriteUserIds': favouriteUserIds,
    };
  }
}
