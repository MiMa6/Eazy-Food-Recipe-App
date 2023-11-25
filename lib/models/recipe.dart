class Recipe {
  String recipeId;
  String recipeName;
  List<String> ingredients;
  List<String> recipeSteps;
  String picture;
  String category;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.ingredients,
    required this.recipeSteps,
    required this.picture,
    required this.category,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      recipeId: id,
      recipeName: data['recipeName'],
      ingredients: List<String>.from(data['ingredients']),
      recipeSteps: List<String>.from(data['recipeSteps']),
      picture: data['picture'],
      category: data['category'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'recipeName': recipeName,
      'ingredients': ingredients,
      'recipeSteps': recipeSteps,
      'picture': picture,
      'category': category,
    };
  }
}

Recipe exampleFeaturedRecipe = Recipe(
  recipeId: '111',
  recipeName: 'Makarooni Hässäkkä',
  ingredients: ["air, water"],
  recipeSteps: ["do, eat"],
  picture: 'pic 1',
  category: 'featured recipe',
);
