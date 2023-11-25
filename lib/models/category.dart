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

List<Category> exampleCategories = [
  Category(
    categoryId: "1",
    categoryName: "Fish",
    picture: "Picture 1",
  ),
  Category(
    categoryId: "2",
    categoryName: "kebab",
    picture: "Picture 1",
  ),
  Category(
    categoryId: "3",
    categoryName: "pizza",
    picture: "Picture 1",
  ),
  Category(
    categoryId: "4",
    categoryName: "Hamburger",
    picture: "Picture 1",
  ),
  Category(
    categoryId: "5",
    categoryName: "Sushi",
    picture: "Picture 1",
  ),
  Category(
    categoryId: "6",
    categoryName: "Random",
    picture: "Picture 1",
  ),
];
