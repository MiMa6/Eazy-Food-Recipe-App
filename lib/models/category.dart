class Category {
  String categoryId;
  String categoryName;
  String picture;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.picture,
  });

  factory Category.fromFirestore(Map<String, dynamic> data, String id) {
    return Category(
      categoryId: id,
      categoryName: data['categoryName'],
      picture: data['picture'],
    );
  }
}
