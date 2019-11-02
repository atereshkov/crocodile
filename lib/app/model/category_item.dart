class CategoryItem {
  final String category;

  CategoryItem({this.category});

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
        category: map['category']
    );
  }

}