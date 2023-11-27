import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../providers/category_provider.dart';
import '../components/text_and_color.dart';

class CommonAppBarWidget extends AppBar {
  CommonAppBarWidget({super.key})
      : super(
          backgroundColor: blueAppBarColor,
          title: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Eazy Food",
                    style: restaurauntTitleTextStyle,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: const SearchRecipeBarWidget()),
                  )),
              const GoLoginPageWidget(),
            ],
          ),
        );
}

class GoLoginPageWidget extends ConsumerWidget {
  const GoLoginPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Center(
          child: IconButton(
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: () {
              context.go('/login');
            },
          ),
        ),
      ],
    );
  }
}

class SearchRecipeBarWidget extends ConsumerWidget {
  const SearchRecipeBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: addRecipeStyleSearchHint,
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
      ),
      onSubmitted: (value) {
        if (controller.text.trim().isEmpty) return;
        context.go('/recipes/bysearch/$value');
        controller.clear();
      },
      textInputAction: TextInputAction.search,
    );
  }
}

class CommonbottomBarWidget extends ConsumerWidget {
  const CommonbottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryNotifier =
        ref.watch(selectedCategoryProvider.notifier);

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.brown),
          label: 'Home',
          backgroundColor: Colors.brown,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.soup_kitchen, color: Colors.brown),
            label: 'Categories',
            backgroundColor: Colors.brown),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks, color: Colors.brown),
            label: 'My Recipes',
            backgroundColor: Colors.brown),

      ],
      onTap: (value) {
        if (value == 0) {
          context.go('/');
        } else if (value == 1) {
          selectedCategoryNotifier.state = '';
          context.go('/categories');
        } else if (value == 2) {
          context.go('/addRecipe');
        }
      },
    );
  }
}
