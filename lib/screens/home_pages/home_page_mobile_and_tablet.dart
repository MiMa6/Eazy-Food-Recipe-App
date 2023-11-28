import 'package:flutter/material.dart';

import '../../widgets/common_bars.dart';
import '../../widgets/category_lists.dart';
import '../../widgets/recipe_tiles.dart';

import '../../components/text_and_color.dart';

class HomePageMobileAndTablet extends StatelessWidget {
  const HomePageMobileAndTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      appBar: CommonAppBarWidget(),
      bottomNavigationBar: const CommonbottomBarWidget(),
      body: SingleChildScrollView(
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

          const SizedBox(height: 20),

          // CATEGORIES
          const SizedBox(height: 300, child: CategoryGrid(layoutType: "mobile")),
        ]),
      ),
    );
  }
}
