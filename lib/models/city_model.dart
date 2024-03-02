import 'dart:convert';
import 'package:http/http.dart' as http;

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
      createdAt: json['createdAt'],
    );
  }

  City copyWith({
    int? id,
    String? name,
    String? slug,
    String? createdAt,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

Future<List<City>> fetchCities() async {
  final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

  if (response.statusCode == 200) {
    // Si la requête réussit, convertissez le corps de la réponse JSON en une liste de villes
    final List<dynamic> data = json.decode(response.body);
    return data.map((cityJson) => City.fromJson(cityJson)).toList();
  } else {
    // Si la requête échoue, lancez une exception ou renvoyez une liste vide selon votre logique d'erreur
    throw Exception('Failed to load cities');
  }
}
