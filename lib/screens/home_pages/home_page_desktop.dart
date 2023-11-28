import 'package:flutter/material.dart';

import '../../widgets/common_bars.dart';
import '../../widgets/category_lists.dart';
import '../../widgets/recipe_tiles.dart';

import '../../widgets/recipe_lists.dart';
import '../../components/text_and_color.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      appBar: CommonAppBarWidget(),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(children: [
                const SizedBox(height: 40),
      
                // SUBTITLE
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.star, size: 20),
                      ),
                      TextSpan(
                        text: " Featured recipe ",
                        style: menuSubTitleTextStyle,
                      ),
                      const WidgetSpan(
                        child: Icon(Icons.star, size: 20),
                      ),
                    ],
                  ),
                ),
      
                const SizedBox(height: 20),
      
                // FEATURED RECEIPE
                const FeaturedRecipeTile(),
                const SizedBox(height: 20),
      
                // SUBTITLE
                Center(
                    child: Text(
                  'Hot Categories Right Now!',
                  style: menuSubTitleTextStyle,
                )),
      
                const SizedBox(height: 10),
      
                const SizedBox(height: 10),
      
                // CATEGORIES
                const SizedBox(height: 300, child: CategoryGrid(layoutType: "mobile")),
              ]),
            ),
            
            Expanded(
              child: Container(
                height: 600,
                color: const Color.fromARGB(255, 27, 139, 164),
                child: Column(children: [
                  const SizedBox(height: 40),
                  
                  // TITLE
                  Center(
                      child: Text(
                    'Favorite Recipes',
                    style: menuSubTitleTextStyle,
                  )),
                  
                  const SizedBox(height: 20),
                  
                  Expanded(
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: const RecipeListByFavorite())),
                  const SizedBox(height: 20),
                ]),
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
