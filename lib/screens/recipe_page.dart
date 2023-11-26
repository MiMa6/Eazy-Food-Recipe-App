import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common_bars.dart';
import '../widgets/recipe_tiles.dart';
import '../components/text_and_color.dart';
import '../providers/recipe_provider.dart';

// TODO: no element when refreshing page
class RecipePage extends ConsumerWidget {
  const RecipePage({super.key, required this.recipeName});
  final String recipeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipeProvider);

    final recipeToShow =
        recipe.where((recipe) => recipe.recipeName == recipeName).first;

    return Scaffold(
      appBar: CommonAppBarWidget(),
      body: SizedBox.expand(
        child: Container(
          color: const Color.fromARGB(255, 27, 139, 164),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20),

              // RECEIPE
              RecipeTileDetailed(recipe: recipeToShow),

              const SizedBox(height: 20),

              // Ingredients
              Center(
                  child: Text(
                'Ingredients:',
                style: menuSubTitleTextStyle,
              ) // TextStyle(fontSize: 20))
                  ),

              const SizedBox(height: 20),

              Center(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: recipeToShow.ingredients.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      recipeToShow.ingredients[index],
                      style: foodTextStyle,
                    ),
                  ) // TextStyle(fontSize: 20))
                      );
                },
              )),

              const SizedBox(height: 40),
              // Steps
              Center(
                  child: Text(
                'Steps:',
                style: menuSubTitleTextStyle,
              ) // TextStyle(fontSize: 20))
                  ),

              const SizedBox(height: 20),

              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Center(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipeToShow.recipeSteps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '(${index + 1}) - ${recipeToShow.recipeSteps[index]}',
                        style: foodTextStyle,
                      ),
                    );
                  },
                )),
              ),

              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
