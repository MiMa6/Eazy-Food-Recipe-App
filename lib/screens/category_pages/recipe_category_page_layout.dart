import 'package:flutter/material.dart';

import '../category_pages/recipe_category_page_mobile.dart';
import '../category_pages/recipe_category_page_tablet.dart';
import '../category_pages/recipe_category_page_desktop.dart';
import '../../components/size_constraints.dart';

class RecipeCategoryPage extends StatelessWidget {
  const RecipeCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return const RecipeCategoryPageMobile();
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return const RecipeCategoryPageTablet();
      } else {
        return const RecipeCategoryPageDesktop();
      }
    });
  }
}
