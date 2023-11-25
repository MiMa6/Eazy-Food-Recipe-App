import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recipe_provider.dart';
import '../../models/recipe.dart';

class RecipeTileDetailed extends StatelessWidget {
  final Recipe recipe;

  const RecipeTileDetailed({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/recipes/byname/${recipe.recipeName}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(25),
        width: 350,
        height: 350,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(recipe.recipeName, style: GoogleFonts.yujiBoku(fontSize: 20)
                //style: GoogleFonts.alice(fontSize: 15, color: Colors.white)
                ),
            Text(recipe.picture, style: GoogleFonts.yujiBoku(fontSize: 10)),
            const Placeholder(
              fallbackHeight: 287,
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeTile extends ConsumerWidget {
  final Recipe recipe;

  const RecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeProviderNotifier = ref.watch(recipeProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            //onTap: {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tileColor: Colors.blue[100],
            leading: const Icon(Icons.favorite_outline),
            title: GestureDetector(
              child: Text(recipe.recipeName,
                  style: GoogleFonts.yujiBoku(fontSize: 20)
                  //style: GoogleFonts.alice(fontSize: 15, color: Colors.white)
                  ),
              onTap: () {
                context.go('/recipes/byname/${recipe.recipeName}');
              },
            ),
            trailing: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                recipeProviderNotifier.deleteRecipe(recipe.recipeId);
              },
            ),
          )
        ],
      ),
    );
  }
}

class FeaturedRecipeTile extends ConsumerWidget {
  const FeaturedRecipeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipeProvider);
    final featuredRecipe =
        recipe.where((recipe) => recipe.recipeName == "Vegan Lasagna").first;

    return GestureDetector(
      onTap: () {
        context.go('/recipes/byname/${featuredRecipe.recipeName}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(25),
        width: 250,
        height: 250,
        child: Column(
          children: [
            Text(featuredRecipe.recipeName,
                //exampleFeaturedRecipe.recipeName,
                style: GoogleFonts.yujiBoku(fontSize: 20)),
            Text(featuredRecipe.category,
                //exampleFeaturedRecipe.recipeName,
                style: GoogleFonts.yujiBoku(fontSize: 10)),
            Text(featuredRecipe.picture,
                //exampleFeaturedRecipe.picture[0],
                style: GoogleFonts.yujiBoku(fontSize: 10)),
            const Placeholder(
              fallbackHeight: 100,
            ),
          ],
        ),
      ),
    );
  }
}
