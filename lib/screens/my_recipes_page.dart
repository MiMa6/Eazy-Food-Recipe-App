import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/common_bars.dart';
import '../providers/recipe_provider.dart';
import '../../providers/user_provider.dart';
import '../../components/text_and_color.dart';

class MyRecipePage extends ConsumerWidget {
  const MyRecipePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    return asyncUser.when(
      data: (user) {
        return user != null
            ? MyRecipePageMain(userUid: user.uid)
            : const MyRecipePageLogin();
      },
      error: (error, stackTrace) {
        return const Center(child: Text("Something went wrong.."));
      },
      loading: () {
        return const Center(child: Text("Loading..."));
      },
    );
  }
}

class MyRecipePageLogin extends StatelessWidget {
  const MyRecipePageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueBackgroundColor,
        appBar: CommonAppBarWidget(),
        bottomNavigationBar: const CommonbottomBarWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Log in to create recipes and add favorites',
                  style: menuSubTitleTextStyle),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: () async {
                  context.go('/login');
                },
              ),
            ],
          ),
        ));
  }
}

class MyRecipePageMain extends ConsumerStatefulWidget {
  final String userUid;
  const MyRecipePageMain({super.key, required this.userUid});

  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends ConsumerState<MyRecipePageMain> {
  final _formKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _recipeStepsController = TextEditingController();

  List<String> categoryOptions = ['Vegan', 'Fish', 'Meat', 'Pizza', 'Kebab'];
  String? selectedCategory;

  _cleanControllers() {
    _recipeNameController.clear();
    _ingredientsController.clear();
    _recipeStepsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProviderNotifier = ref.watch(recipeProvider.notifier);
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      appBar: CommonAppBarWidget(),
      bottomNavigationBar: const CommonbottomBarWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // TITLE
                  Center(
                      child: Text(
                    'Add Recipe',
                    style: menuSubTitleTextStyle,
                  )),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _recipeNameController,
                    decoration: InputDecoration(
                      labelText: 'Recipe Name',
                      labelStyle: addRecipeStyleSearch,
                      helperText: "Write name for your recipe",
                      helperStyle: addRecipeStyleSearchHint,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a recipe name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _ingredientsController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Ingredients',
                      labelStyle: addRecipeStyleSearch,
                      helperText:
                          "Use '/' to separate steps, e.g. Ingredients1 / Ingredients2",
                      helperStyle: addRecipeStyleSearchHint,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ingredients';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _recipeStepsController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Steps',
                      labelStyle: addRecipeStyleSearch,
                      helperText:
                          "Use '/' to separate steps, e.g. step1 / step2",
                      helperStyle: addRecipeStyleSearchHint,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter recipe steps';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: addRecipeStyleSearch,
                      helperText:
                          "Click field and choose from list of categories",
                      helperStyle: addRecipeStyleSearchHint,
                    ),
                    value: selectedCategory,
                    items: categoryOptions.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        recipeProviderNotifier.addRecipe(
                          _recipeNameController.text,
                          _ingredientsController.text.split("/"),
                          _recipeStepsController.text.split("/"),
                          selectedCategory!,
                        );
                        _cleanControllers();
                      }
                    },
                    child: const Text('Submit =>'),
                  ),
                  const SizedBox(height: 40),
                  // TITLE
                  Center(
                      child: Text(
                    'Favorite Recipes',
                    style: menuSubTitleTextStyle,
                  )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/favoriteRecipe');
                    },
                    child: const Text('Go Favorites <3'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
