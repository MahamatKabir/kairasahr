import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class YourApi {
  static const String baseUrl = 'http://kairasarl.yerimai.com';

  static Future<List<String>> fetchContainerIDs() async {
    // Replace this URL with your actual API endpoint
    const String apiUrl = '$baseUrl/containerIDs';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        final List<dynamic> data = json.decode(response.body);

        // Assuming the JSON response is a list of container IDs
        List<String> containerIDs =
            data.map((item) => item.toString()).toList();

        return containerIDs;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load container IDs');
      }
    } catch (e) {
      // If there's an error with the HTTP request, throw an exception
      throw Exception('Failed to load container IDs: $e');
    }
  }
}

class ApiService {
  static const String baseUrl = 'http://kairasarl.yerimai.com';
  static Future<List<Map<String, dynamic>>> fetchCityData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cities'));
      if (response.statusCode == 200) {
        final List<dynamic> cities = jsonDecode(response.body);
        return cities.map((city) {
          return {
            'id': city['id'],
            'name': city['name'],
          };
        }).toList();
      } else {
        // throw Exception('Failed to load city data');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow the exception to handle it where it's called
    }
    return [];
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
  static const String baseUrl = 'http://kairasarl.yerimai.com';
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
  static const String baseUrl = 'http://kairasarl.yerimai.com';
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
