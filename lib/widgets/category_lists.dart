import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/category_provider.dart';
import '../models/category.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catergories = ref.watch(categoryProvider);
    //final hotCategories = categories.where(catergories => catergories.hotCategory == true).toList()
    
    if (catergories.isEmpty || catergories == []){
        return const Center(child: Text("Loading...."));
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, //CHANGE responsively
          childAspectRatio: 6 / 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CategoryTileGrid(category: catergories[index]);
        },
      );
    }
  }
}


class CategoryTileGrid extends ConsumerWidget {
  final Category category;

  const CategoryTileGrid({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryNotifier =
        ref.watch(selectedCategoryProvider.notifier);
    final searchedCategoryNotifier =
        ref.watch(searchedCategoryProvider.notifier);

    return GestureDetector(
      onTap: () {
        selectedCategoryNotifier.state = category.categoryName;
        searchedCategoryNotifier.state = '';
        context.go('/categories');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(category.categoryName,
                style: GoogleFonts.yujiBoku(fontSize: 20)),
            Text('list2', style: GoogleFonts.yujiBoku(fontSize: 20)),
            // PICTURE PLACEHOLDER
            const Placeholder(
              fallbackHeight: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends ConsumerWidget {
  final String deviceType;
  const CategoryList({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catergories = ref.watch(categoryProvider);

    return ListView.builder(
      itemCount: catergories.length,
      itemBuilder: (context, index) {
        return CategoryTileList(
            category: catergories[index], deviceType: deviceType);
      },
    );
  }
}

class CategoryTileList extends ConsumerWidget {
  final Category category;
  final String deviceType;

  const CategoryTileList(
      {super.key, required this.category, required this.deviceType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryNotifier =
        ref.watch(selectedCategoryProvider.notifier);

    return GestureDetector(
      onTap: () {
        selectedCategoryNotifier.state = category.categoryName;
        if (deviceType == 'mobile') {
          context.go('/recipesList');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(category.categoryName,
                style: GoogleFonts.yujiBoku(fontSize: 20)),
            // PICTURE PLACEHOLDER
            const Placeholder(
              fallbackHeight: 150,
            ),
          ],
        ),
      ),
    );
  }
}
