import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/user_provider.dart';
import '../providers/recipe_provider.dart';

import '../../models/recipe.dart';

class FavouriteWidget extends ConsumerWidget {
  final Recipe recipe;

  const FavouriteWidget({super.key, required this.recipe});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeProviderNotifier = ref.watch(recipeProvider.notifier);
    final asyncUser = ref.watch(userProvider);

    //Text(recipe.favouriteUserIds.length.toString()),
    // ADD & DELETE FAVOURITE RECIPE
    return asyncUser.when(data: (user) {
      if (user != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(
                Icons.favorite,
                color: recipe.favouriteUserIds.contains(user.uid)
                    ? Colors.green
                    : Colors.grey,
              ),
              onTap: () {
                if (recipe.favouriteUserIds.contains(user.uid)) {
                  recipeProviderNotifier.delFavourite(
                      recipe.recipeId, user.uid);
                } else {
                  recipeProviderNotifier.addFavourite(
                      recipe.recipeId, user.uid);
                }
              },
            ),
            Text((recipe.favouriteUserIds.length - 1).toString()),
          ],
        );
      }
      return const Text("");
    }, loading: () {
      return const Text("");
    }, error: (error, stackTrace) {
      return const Text("");
    });
  }
}

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
        return Text("");
      }
      return Text("");
    }, loading: () {
      return Text("");
    }, error: (error, stackTrace) {
      return Text("");
    });
  }
}
