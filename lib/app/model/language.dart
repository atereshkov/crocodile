class Language {
  final int id;
  final String name;
  final String code;
  final String country;

  Language(this.id, this.name, this.code, this.country);

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      map['id'],
      map['code'],
      map['country'],
      map['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'country': country,
    'name': name,
  };
}