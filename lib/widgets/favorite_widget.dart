import 'package:flutter/material.dart';
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
