class TeamItem {
  String name;
  final String id;

  TeamItem({this.name, this.id});

  void rename(String newName) {
    this.name = newName;
  }
}