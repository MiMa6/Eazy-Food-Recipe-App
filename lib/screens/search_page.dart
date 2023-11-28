import 'package:flutter/material.dart';
import '../widgets/common_bars.dart';
import '../components/text_and_color.dart';
import '../widgets/recipe_lists.dart';

class RecipeListBySearcbPage extends StatelessWidget {
  const RecipeListBySearcbPage({super.key, required this.searchPattern});
  final String searchPattern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(),
      body: Container(
        color: const Color.fromARGB(255, 27, 139, 164),
        child: Column(children: [
          const SizedBox(height: 40),

          // TITLE
          Center(
              child: Text(
            'Recipes by search',
            style: menuSubTitleTextStyle,
          )),

          const SizedBox(height: 20),

          Expanded(
              child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: RecipeListBySearch(searchPattern: searchPattern))),
          const SizedBox(height: 20),
        ]),
      ),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
