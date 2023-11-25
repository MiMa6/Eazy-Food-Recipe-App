import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../widgets/common_bars.dart';
import '../../components/text_and_color.dart';
import '../../widgets/recipe_lists.dart';
import '../../providers/category_provider.dart';

class RecipeListPageMobile extends ConsumerWidget {
  const RecipeListPageMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    String pageTitle = 'Recipes in category "$selectedCategory"';

    return Scaffold(
      backgroundColor: blueBackgroundColor,
      appBar: CommonAppBarWidget(),
      body: Column(children: [
        const SizedBox(height: 40),

        // SUBTITLE
        Center(
            child: Text(
          pageTitle,
          style: menuSubTitleTextStyle,
        ) // TextStyle(fontSize: 20))
            ),

        const SizedBox(height: 20),

        // RECIPES IN CATEGORY LIST
        Expanded(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: RecipeListCategory(categoryName: selectedCategory)))
      ]),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
