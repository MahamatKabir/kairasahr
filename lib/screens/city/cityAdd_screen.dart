import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CityAddScreen extends StatefulWidget {
  const CityAddScreen({super.key});

  @override
  State<CityAddScreen> createState() => _CityAddScreenState();
}

class _CityAddScreenState extends State<CityAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isAddingCity = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.indigo.shade50,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Nom de la ville',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: '', border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ]),
            ),
            ElevatedButton(
              style: buttonPrimary,
              onPressed: _isAddingCity ? null : _addCity,
              child: _isAddingCity
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _addCity() async {
    setState(() {
      _isAddingCity = true;
    });

    final cityName = _nameController.text.trim();
    final cityId = _generateCityId(); // Génération automatique de l'ID
    final createdAt = DateTime.now().toIso8601String();

    if (cityName.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://votre-api-url/cities'),
        body: json.encode({
          'id': cityId,
          'name': cityName,
          'created_at': createdAt,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Ville ajoutée avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de l\'ajout de la ville')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }

    setState(() {
      _isAddingCity = false;
    });
  }

  String _generateCityId() {
    const uuid = Uuid();
    return uuid.v4(); // Génère un UUID v4 aléatoire
  }
}
