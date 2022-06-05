enum CategoryName { main, food, daily, emotions, tamlamalar, needs, other }

class Category {
  const Category({required this.categoryName, required this.categoryTitle});
  final CategoryName categoryName;
  final String categoryTitle;
}
