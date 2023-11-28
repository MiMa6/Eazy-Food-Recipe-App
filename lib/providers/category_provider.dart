import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier() : super([]) {
    _fetchCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchCategories() async {
    final snapshot = await _firestore.collection('categories').get();

    // For debugging purposes
    /*for (var doc in snapshot.docs) {
      print('Categories from firestore: ${doc.id}: ${doc.data()}');
    }*/

    final categories = snapshot.docs
        .map((doc) => Category.fromFirestore(doc.data(), doc.id))
        .toList();
    state = categories;

  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>(
        (ref) => CategoryNotifier());

final selectedCategoryProvider = StateProvider<String>((ref) => '');