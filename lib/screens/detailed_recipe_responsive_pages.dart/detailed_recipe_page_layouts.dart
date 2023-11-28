import 'package:flutter/material.dart';

import '../../components/size_constraints.dart';
import './detailed_recipe_page_mobile.dart';
import './detailed_recipe_page_tablet.dart';
import './detailed_recipe_page_desktop.dart';

class RecipePage extends StatelessWidget {
  final String recipeName;
  const RecipePage({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return RecipePageMobile(recipeName: recipeName);
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return RecipePageTablet(recipeName: recipeName);
      } else {
        return RecipePageDesktop(recipeName: recipeName);
      }
    });
  }
}
