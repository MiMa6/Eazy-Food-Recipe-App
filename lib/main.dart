import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/screens/add_recipe_page.dart';
import 'firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'screens/home_pages/home_page_layout.dart';
import 'screens/category_and_recipe_list_pages/category_and_recipe_list_page_layouts.dart';
import 'screens/search_page.dart';
import 'screens/recipe_page.dart';
import 'screens/login_page.dart';

import 'components/text_and_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) =>  HomePage()),
      GoRoute(path: '/login', builder: (context, state) =>  LoginPage()),
      GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoryPage()),
      GoRoute(
          path: '/recipesList',
          builder: (context, state) => const RecipeListPage()),
      GoRoute(
          path: '/addRecipe',
          builder: (context, state) => const AddRecipePage()),
      GoRoute(
          path: '/recipes/byname/:recipeName',
          builder: (context, state) =>
              RecipePage(recipeName: state.pathParameters['recipeName']!)),
      GoRoute(
          path: '/recipes/bysearch/:searchPattern',
          builder: (context, state) => RecipeListBySearcbPage(
              searchPattern: state.pathParameters['searchPattern']!)),
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
