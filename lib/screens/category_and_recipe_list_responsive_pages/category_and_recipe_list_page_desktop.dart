import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/common_bars.dart';
import '../../widgets/category_lists.dart';
import '../../components/text_and_color.dart';
import '../../widgets/recipe_lists.dart';
import '../../providers/category_provider.dart';

class CategoryAndRecipeListPageDesktop extends ConsumerWidget {
  const CategoryAndRecipeListPageDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: blueBackgroundColor,
      appBar: CommonAppBarWidget(),
      body: Column(children: [
        // CATEGORIES
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(),
              ),
              // CATEGORY LIST
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // SUBTITLE
                    Center(
                        child: Text(
                      'Categories',
                      style: menuSubTitleTextStyle,
                    ) // TextStyle(fontSize: 20))
                        ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 500,
                            ),
                            child: const CategoryListSmooth(
                              layoutType: 'desktop',
                            )))
                  ],
                ),
              ),
              // RECIPES IN CATEGORY LIST
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // SUBTITLE
                      Center(
                          child: (selectedCategory != '')
                              ? Text('Recipes in category "$selectedCategory"',
                                  style: menuSubTitleTextStyle)
                              : Text('Select category for recipes',
                                  style:
                                      menuSubTitleTextStyle) // TextStyle(fontSize: 20))
                          ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                              ),
                              child: RecipeListByCategorySmooth(
                                  categoryName: selectedCategory)))
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        )
      ]),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
