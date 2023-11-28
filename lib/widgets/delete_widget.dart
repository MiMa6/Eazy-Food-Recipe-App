import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/user_provider.dart';
import '../providers/recipe_provider.dart';

import '../../models/recipe.dart';

class DeleteWidget extends ConsumerWidget {
  final Recipe recipe;

  const DeleteWidget({super.key, required this.recipe});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeProviderNotifier = ref.watch(recipeProvider.notifier);
    final asyncUser = ref.watch(userProvider);

    // DELETE RECIPE
    return asyncUser.when(data: (user) {
      if (user != null) {
        if (user.uid == recipe.userId) {
          return GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () {
              recipeProviderNotifier.deleteRecipe(recipe.recipeId);
              context.go('/categories');
            },
          );
        }
        return const Text("");
      }
      return const Text("");
    }, loading: () {
      return const Text("");
    }, error: (error, stackTrace) {
      return const Text("");
    });
  }
}
