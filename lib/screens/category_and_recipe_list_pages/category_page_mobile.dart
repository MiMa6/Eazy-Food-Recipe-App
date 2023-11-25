import 'package:flutter/material.dart';
import '../../widgets/common_bars.dart';
import '../../widgets/category_lists.dart';
import '../../components/text_and_color.dart';

class CategoryPageMobile extends StatelessWidget {
  const CategoryPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    String pageTitle = 'Categories';

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

        // CATEGORY LIST
        Expanded(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: const CategoryList(deviceType: 'mobile')))
      ]),
      bottomNavigationBar: const CommonbottomBarWidget(),
    );
  }
}
