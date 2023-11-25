import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/screens/add_recipe_page.dart';
import 'firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'screens/home_pages/home_page_layout.dart';
import 'screens/category_pages/recipe_category_page_layout.dart';
import 'screens/search_page.dart';
import 'screens/recipe_page.dart';

import 'components/text_and_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
          path: '/categories',
          builder: (context, state) => const RecipeCategoryPage()),
      GoRoute(path: '/addRecipe', builder: (context, state) => const AddRecipePage()),
      GoRoute(
          path: '/recipes/bysearch/:searchPattern',
          builder: (context, state) => RecipeListBySearcbPage(
              searchPattern: state.pathParameters['searchPattern']!)),
      GoRoute(
          path: '/recipes/byname/:recipeName',
          builder: (context, state) =>
              RecipePage(recipeName: state.pathParameters['recipeName']!)),
    ],
  );

  runApp(ProviderScope(
    child: MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
        textTheme: textThemeCustom,
      ),
    ),
  ));
}