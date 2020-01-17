class CategoryItem {
  final String name;
  final String id;

  CategoryItem({this.name, this.id});

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
      name: map['name'],
      id: map['id'],
    );
  }

}