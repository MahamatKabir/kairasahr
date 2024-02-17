class City {
  int id;
  String name;
  String slug;
  String createdAt;

  City({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json[null],
    );
  }
}
