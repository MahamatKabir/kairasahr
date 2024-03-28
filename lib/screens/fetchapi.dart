import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
            id: int.parse(data['id'].toString()),
            name: data['container_name'] ?? '',
            plaque: data['container_plate'] ?? '',
            slug: data['slug'] ?? '',
            customer: data['customer'] ?? '',
            customerPhone: data['customer_phone']?.toString() ?? '',
            broker: data['broker'] ?? '',
            brokerPhone: data['broker_phone'] ?? '',
            containerPrice:
                double.parse(data['container_price']?.toString() ?? '0'),
            containerCityID: data['city']['name'] ?? '',
            containerType: data['type']['name'],
            status: data['status'],
            containerInformationC: data['container_information_c'] ?? '',
            containerOtherDetails: data['container_other_details'] ?? '',
            createdAt: data['created_at'] ?? '',
            createdBy: data['created_by'] ?? '',
            containerRelatedExpenses:
                (data['container_related_expenses'] as List<dynamic>?)
                    ?.map((item) => Expense.fromJson(item))
                    .toList(),
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
              paid: data['paid'],
              details: data['total'],
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

  static Future<void> createExpense({
    required List<Map<String, dynamic>> contExpenses,
    required String details,
  }) async {
    // Envoyer les données à votre API
    try {
      // Construire le corps de la requête
      Map<String, dynamic> requestBody = {
        'details': details,
        'contExpenses': contExpenses,
      };

      // Envoyer la requête POST à votre API
      final response = await http.post(
        Uri.parse('$baseUrl/expenses'), // Remplacez ceci par l'URL de votre API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        // La dépense a été ajoutée avec succès
        print('Dépense ajoutée avec succès');
      } else {
        // Gérer les erreurs
        print('Erreur lors de l\'ajout de la dépense: ${response.statusCode}');
        print('Réponse: ${response.body}');
        throw Exception('Échec de l\'ajout de la dépense');
      }
    } catch (e) {
      // Gérer les erreurs en cas d'échec de la requête
      print('Erreur lors de la connexion à l\'API: $e');
      throw Exception('Échec de la connexion à l\'API');
    }
  }

  static Future<void> createAuthExpense({
    required List<Map<String, dynamic>> contExpenses,
    required String details,
  }) async {
    // Envoyer les données à votre API
    try {
      // Construire le corps de la requête
      Map<String, dynamic> requestBody = {
        'details': details,
        'contExpenses': contExpenses,
      };

      // Envoyer la requête POST à votre API
      final response = await http.post(
        Uri.parse(
            '$baseUrl/other-expenses'), // Remplacez ceci par l'URL de votre API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Dépenses ajoutées avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // La dépense a été ajoutée avec succès
        print('Dépense ajoutée avec succès');
      } else {
        // Gérer les erreurs
        print('Erreur lors de l\'ajout de la dépense: ${response.statusCode}');
        print('Réponse: ${response.body}');
        throw Exception('Échec de l\'ajout de la dépense');
      }
    } catch (e) {
      // Gérer les erreurs en cas d'échec de la requête
      print('Erreur lors de la connexion à l\'API: $e');
      throw Exception('Échec de la connexion à l\'API');
    }
  }

  static Future<void> updateExpense(Expenses expense) async {
    final response = await http.put(
      Uri.parse('$baseUrl/other-expenses/${expense.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(expense.toJson()),
    );
    print(response.body);
    print(jsonEncode(expense.toJson()));
    if (response.statusCode != 200) {
      throw Exception('Failed to update expense: ${response.statusCode}');
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

class ApiClient {
  // ... other API methods

  static Future<http.Response> updateContainer(
      int id, Map<String, dynamic> body) async {
    // Construct the API request URL and headers
    final url = Uri.parse(
        'http://kairasarl.yerimai.com/api/v1/containers/$id'); // Replace with actual API endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json', // Adjust if needed
      // 'Authorization': 'Bearer your-api-token' // Include if authentication is required
    };

    // Encode the request body as JSON
    final jsonBody = jsonEncode(body);
    print(jsonEncode(body));

    // Send the PUT request
    try {
      final response = await http.put(url, headers: headers, body: jsonBody);
      print(json.decode(response.body));
      return response;
    } catch (error) {
      // Handle network errors or API failures
      throw Exception('Failed to update container: $error');
    }
  }
}
