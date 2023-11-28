import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

import '../components/recipe_selection_home.dart';
import '../components/text_and_color.dart';
import '../providers/category_provider.dart';
import '../models/category.dart';

class CategoryGrid extends ConsumerWidget {
  final String layoutType;
  const CategoryGrid({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catergories = ref.watch(categoryProvider);
  
    final hotCategoriesGet = catergories
    .where((category) => hotCategoryNames.contains(category.categoryName)).toList();

    if (catergories.isEmpty || catergories == []) {
      return const Center(child: Text("Loading...."));
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, //CHANGE responsively
          childAspectRatio: 6 / 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: hotCategoriesGet.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CategoryTileGrid(
            category: hotCategoriesGet[index],
            layoutType: layoutType,
          );
        },
      );
    }
  }
}

class CategoryTileGrid extends ConsumerWidget {
  final Category category;
  final String layoutType;

  const CategoryTileGrid(
      {super.key, required this.category, required this.layoutType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryNotifier =
        ref.watch(selectedCategoryProvider.notifier);
    return GestureDetector(
      onTap: () {
        selectedCategoryNotifier.state = category.categoryName;
        (layoutType == 'mobile')
            ? context.go('/recipesList')
            : context.go('/categories');
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
              fallbackHeight: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListSmooth extends ConsumerWidget {
  final String layoutType;
  const CategoryListSmooth({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesQuery = FirebaseFirestore.instance
        .collection('categories')
        .orderBy('categoryName');

    return FutureBuilder<QuerySnapshot>(
      future: categoriesQuery.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No categories available",
              style: menuSubTitleTextStyle,
            ),
          );
        } else {
          return FirestoreListView<Map<String, dynamic>>(
            pageSize: 20,
            query: categoriesQuery,
            itemBuilder: (context, snapshot) {
              final category =
                  Category.fromFirestore(snapshot.data(), snapshot.id);
              return CategoryTileList(
                  category: category, layoutType: layoutType);
            },
          );
        }
      },
    );
  }
}

class CategoryTileList extends ConsumerWidget {
  final Category category;
  final String layoutType;

  const CategoryTileList(
      {super.key, required this.category, required this.layoutType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryNotifier =
        ref.watch(selectedCategoryProvider.notifier);

    return GestureDetector(
      onTap: () {
        selectedCategoryNotifier.state = category.categoryName;
        if (layoutType == 'mobile') {
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
