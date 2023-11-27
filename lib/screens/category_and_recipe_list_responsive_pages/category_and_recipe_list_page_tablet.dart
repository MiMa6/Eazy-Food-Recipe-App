import 'package:flutter/material.dart';
import '../../widgets/common_bars.dart';
import '../../widgets/category_lists.dart';
import '../../components/text_and_color.dart';
import '../../widgets/recipe_lists.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/category_provider.dart';

class CategoryAndRecipeListPageTablet extends ConsumerWidget {
  const CategoryAndRecipeListPageTablet({super.key});

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
            children: [
              // CATEGORY LIST
              Expanded(
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
                              maxWidth: 400,
                            ),
                            child: const CategoryListSmooth(
                              layoutType: 'tablet',
                            )))
                  ],
                ),
              ),
              // RECIPES IN CATEGORY LIST
              Expanded(
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
                            maxWidth: 400,
                          ),
                          child: RecipeListByCategorySmooth(
                              categoryName: selectedCategory)))
                ],
              )),
            ],
          ),
        )
      ]),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
