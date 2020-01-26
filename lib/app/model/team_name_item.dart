class TeamNameItem {
  final String name;

  TeamNameItem({this.name});

  factory TeamNameItem.fromMap(Map<String, dynamic> map) {
    return TeamNameItem(
      name: map['name'],
    );
  }

}