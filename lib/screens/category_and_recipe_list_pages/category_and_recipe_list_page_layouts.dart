import 'package:flutter/material.dart';

import 'recipes_list_page_mobile.dart';
import 'category_and_recipe_list_page_tablet.dart';
import 'category_and_recipe_list_page_desktop.dart';

import 'category_page_mobile.dart';
import '../../components/size_constraints.dart';

// TODO: Smooth scrolling
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return const CategoryPageMobile();
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return const CategoryAndRecipeListPageTablet();
      } else {
        return const CategoryAndRecipeListPageDesktop();
      }
    });
  }
}

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return const RecipeListPageMobile();
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return const CategoryAndRecipeListPageTablet();
      } else {
        return const CategoryAndRecipeListPageDesktop();
      }
    });
  }
}
