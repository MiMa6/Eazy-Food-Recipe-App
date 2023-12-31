import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/common_bars.dart';
import '../../widgets/recipe_tiles.dart';
import '../../components/text_and_color.dart';
import '../../providers/recipe_provider.dart';
import '../../models/recipe.dart';

class RecipePageDesktop extends ConsumerWidget {
  const RecipePageDesktop({super.key, required this.recipeName});
  final String recipeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeToShowFuture =
        ref.watch(recipeProvider.notifier).getRecipeByName(recipeName);


    return Scaffold(
      appBar: CommonAppBarWidget(),
      bottomNavigationBar: const CommonbottomBarWidget(),
      body: SizedBox.expand(
        child: Container(
          color: blueBackgroundColor,
          child: 
          FutureBuilder<Recipe>(
                future: recipeToShowFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<Recipe> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 20),

                    // RECEIPE
                    RecipeTileDetailed(recipe: snapshot.data!),

                    const SizedBox(height: 20),
                  ]),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
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
                      itemCount: snapshot.data!.ingredients.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            snapshot.data!.ingredients[index],
                            style: foodTextStyle,
                          ),
                        ) // TextStyle(fontSize: 20))
                            );
                      },
                    )),
                  ]),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
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
                        itemCount: snapshot.data!.recipeSteps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '(${index + 1}) - ${snapshot.data!.recipeSteps[index]}',
                              style: foodTextStyle,
                            ),
                          );
                        },
                      )),
                    ),

                          const SizedBox(height: 20),
                        ]),
                      ))
                    ]);
                  }
                }),
          ),
        ));
  }
}
