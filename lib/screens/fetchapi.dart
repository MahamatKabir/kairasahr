import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kairasahrl/models/city_model.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:uuid/uuid.dart';

class Conteneurre {
  final int id;
  final String name;
  final int status; // Nouveau champ pour le statut

  Conteneurre({required this.id, required this.name, required this.status});

  factory Conteneurre.fromJson(Map<String, dynamic> json) {
    return Conteneurre(
      id: json['id'] ?? 0,
      name: json['container_name'] ?? '',
      status:
          json['status'] ?? 0, // Récupère le statut à partir des données JSON
    );
  }
}

class ContainerDepenseApi {
  static const String baseUrl = 'http://kairasarl.yerimai.com/api/v1';

  static Future<List<Conteneurre>> fetchContainerDepense() async {
    const String apiUrl = '$baseUrl/containers';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];

        List<Conteneurre> containers = [];

        for (var data in responseData) {
          containers.add(Conteneurre(
              id: data['id'] ?? 0,
              name: data['container_name'] ?? '',
              status: data['Status'] == "Actif"
                  ? 1
                  : data['Status'] == "Passif"
                      ? 0
                      : data['Status'] == "Standby"
                          ? 2
                          : -1));
        }

        return containers;
      } else {
        throw Exception('Failed to load containers');
      }
    } catch (e) {
      throw Exception('Failed to load containers: $e');
    }
  }
}

class YourApi {
  static const String baseUrl = 'http://kairasarl.yerimai.com/api/v1';

  static Future<List<Conteneure>> fetchContainers() async {
    const String apiUrl = '$baseUrl/containers';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];

        List<Conteneure> containers = [];

        for (var data in responseData) {
          containers.add(Conteneure(
            id: data['id'] ?? 0,
            name: data['container_name'] ?? '',
            plaque: data['plaque'] ?? '',
            slug: data['slug'] ?? '',
            customer: data['customer'] ?? '',
            customerPhone: data['customer_phone']?.toString() ?? '',
            broker: data['broker'] ?? '',
            brokerPhone: data['broker_phone'] ?? '',
            containerPrice:
                double.parse(data['container_price']?.toString() ?? '0'),
            containerCityID: data['container_city_id'] != null
                ? data['container_city_id'].toString()
                : '',
            containerType: data['container_type'] == "40 Pieds" ? 2 : 1,
            status: data['Status'] == "Actif"
                ? 1
                : data['Status'] == "Passif"
                    ? 0
                    : data['Status'] == "Standby"
                        ? 2
                        : -1,
            containerInformationC: data['container_information_c'] ?? '',
            containerOtherDetails: data['container_other_details'] ?? '',
            createdAt: data['created_at'] ?? '',
            createdBy: data['created_by'] ?? '',
          ));
        }

        return containers;
      } else {
        throw Exception('Failed to load containers');
      }
    } catch (e) {
      throw Exception('Failed to load containers: $e');
    }
  }

  static Future<void> updateContainer(
      String containerId, Conteneure container) async {
    final int parsedId =
        int.tryParse(containerId) ?? 0; // Default to 0 if parsing fails
    final String apiUrl = '$baseUrl/containers/$parsedId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          // Add authentication header if required by your API
          // 'Authorization': 'Bearer YourAccessToken',
        },
        body: jsonEncode(container.toJson()),
      );

      if (response.statusCode == 200) {
        // Container updated successfully
      } else {
        throw Exception('Failed to update container: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update container: $e');
    }
  }

  static Future<void> deleteContainer(int id) async {
    final String apiUrl = '$baseUrl/containers/$id';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // La suppression a réussi, vous pouvez traiter la réponse en conséquence si nécessaire
        print('Container with ID $id deleted successfully');
      } else {
        throw Exception('Failed to delete container');
      }
    } catch (e) {
      throw Exception('Failed to delete container: $e');
    }
  }

  static Future<List<Expense>> fetchExpenses() async {
    const String apiUrl = '$baseUrl/expenses';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];

        List<Expense> expenses = [];

        for (var data in responseData) {
          expenses.add(
            Expense(
              id: data['id'] ?? 0,
              article: data['article'] ?? '',
              slug: data['slug'] ?? '',
              total: data['total'],
              paid: data['paid'],
              containerID: data['Conteneur'] ?? '',
              createdBy: data['Creer Par'] ?? '',
              createdAt: data['Date de Création'] ?? '',
              updatedBy: data['Mise a jour Par'] ?? '',
              updatedAt: data['Date de mise a jour'] ?? '',
            ),
          );
        }

        return expenses;
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      throw Exception('Failed to load expenses: $e');
    }
  }
}

class ApiService {
  static const String baseUrl = 'http://kairasarl.yerimai.com/api/v1';

  static Future<List<Map<String, dynamic>>> fetchCities() async {
    final response = await http.get(Uri.parse('$baseUrl/cities'));

    if (response.statusCode == 200) {
      final List<dynamic> citiesData = json.decode(response.body);
      return citiesData.map((json) {
        return {
          'id': json['id'],
          'name': json['name'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load cities: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchCityData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cities'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> cities = responseData['data'];
        return cities.map((city) {
          return {
            'id': city['id'],
            'name': city['name'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  static Future<void> deleteCity(int id) async {
    final url =
        '$baseUrl/cities/$id'; // URL de l'API pour supprimer une ville par son ID
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        // La suppression a réussi côté serveur, vous pouvez également supprimer la ville de votre liste locale
        print('Ville supprimée avec succès de l\'API');
      } else {
        // Gérer les cas d'erreur, comme si la ville n'a pas pu être supprimée côté serveur
        print(
            'La suppression de la ville a échoué. Code de statut: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion, etc.
      print('Erreur lors de la suppression de la ville: $e');
    }
  }

  static Future<void> updateCity(int id, String newName) async {
    final url = '$baseUrl/cities/$id';
    final Map<String, String> body = {
      'name': newName,
      // Ajoutez d'autres champs à mettre à jour selon vos besoins
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Ville mise à jour avec succès');
      } else {
        throw Exception('Échec de la mise à jour de la ville');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de la ville: $e');
      throw e;
    }
  }

  static Future<bool> addContainer(Map<String, dynamic> containerData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/containers'),
        body: json.encode(containerData),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchContainers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/containers'));
      if (response.statusCode == 200) {
        final List<dynamic> containers = jsonDecode(response.body);
        return containers.map((container) {
          return {
            'id': container['id'],
            'name': container['name'],
          };
        }).toList();
      } else {
        // throw Exception('Failed to load container data');
      }
    } catch (e) {
      // throw Exception('Failed to load container data: $e');
    }
    return [];
  }
}

class CityService {
  static const String baseUrl = 'http://kairasarl.yerimai.com/api/v1';
  static Future<String> addCity(String cityName) async {
    final cityId = _generateCityId();
    final createdAt = DateTime.now().toIso8601String();

    final response = await http.post(
      Uri.parse('$baseUrl/cities'),
      body: json.encode({
        'id': cityId,
        'name': cityName,
        'created_at': createdAt,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return 'success';
    } else {
      return 'failure';
    }
  }

  static String _generateCityId() {
    final uuid = Uuid();
    return uuid.v4();
  }
}

class AddExpenseService {
  static const String baseUrl = 'http://kairasarl.yerimai.com/api/v1';
  static Future<void> addExpense({
    required Map<String, dynamic> itemData,
    required String slug,
    required BuildContext context,
  }) async {
    final expenseId = _generateExpenseId();
    final createdAt = DateTime.now().toIso8601String();

    // Assurez-vous que toutes les données nécessaires sont présentes dans itemData
    if (itemData['article'] != null &&
        itemData['total'] != null &&
        itemData['paid'] != null &&
        itemData['selectedContainerID'] != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/expenses'),
        body: json.encode({
          'id': expenseId,
          'article': itemData['article'],
          'total': itemData['total'],
          'paid': itemData['paid'],
          'slug': slug,
          'container_id': itemData['selectedContainerID'],
          'created_at': createdAt,
          // Ajoutez d'autres données spécifiques de l'élément ici
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Dépense ajoutée avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de l\'ajout de la dépense')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Données de dépense non valides')),
      );
    }
  }

  static Future<void> createExpense({
    required String article,
    required int total,
    required int paid,
    required int containerID,
  }) async {
    const String apiUrl = '$baseUrl/expenses';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'article': article,
          'total': total,
          'paid': paid,
          'containerID': containerID,
        }),
      );

      if (response.statusCode == 200) {
        // Si la requête est réussie (statut 200), la dépense est ajoutée avec succès
        print('Expense added successfully');
      } else {
        // Si la requête échoue, lancez une exception avec le message d'erreur
        throw Exception('Failed to add expense: ${response.body}');
      }
    } catch (e) {
      // Gère les erreurs d'envoi de la requête
      throw Exception('Failed to add expense: $e');
    }
  }

  static String _generateExpenseId() {
    const uuid = Uuid();
    return uuid.v4();
  }
}

class AuthService {
  static Future<String?> signIn(String email, String password) async {
    final Uri apiUrl = Uri.parse('http://kairasarl.yerimai.com/api/v1/login');
    final response = await http.post(
      apiUrl,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Connexion réussie, retournez le jeton d'authentification
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? token = responseData['token'];
      return token;
    } else {
      // Échec de la connexion, retournez null
      return null;
    }
  }
}
