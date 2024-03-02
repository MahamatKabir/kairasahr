import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/costomeProgress.dart';
import 'package:kairasahrl/widget/button.dart';
// Importez le widget personnalisé

class CityAddScreen extends StatefulWidget {
  const CityAddScreen({Key? key}) : super(key: key);

  @override
  State<CityAddScreen> createState() => _CityAddScreenState();
}

class _CityAddScreenState extends State<CityAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isAddingCity = false;
  bool _isFieldEmpty = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer
        .cancel(); // Assurez-vous d'annuler le timer lors de la suppression de l'écran
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.indigo.shade100,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
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
                    'Nom du Ville',
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
                      border: _isFieldEmpty
                          ? Border.all(color: Colors.red, width: 2.0)
                          : null,
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: '',
                        border: InputBorder.none,
                        errorText: _isFieldEmpty
                            ? 'Veuillez remplir tous les champs'
                            : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isFieldEmpty = value.isEmpty;
                        });
                      },
                    ),
                  ),
                  if (_isFieldEmpty)
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 4),
                      child: Text(
                        'Veuillez remplir tous les champs',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: buttonPrimary,
              onPressed: _isAddingCity || _isFieldEmpty
                  ? null
                  : () {
                      _timer = Timer(Duration(seconds: 5), () {
                        setState(() {
                          _isAddingCity = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Délai dépassé. Veuillez réessayer.')),
                        );
                      });
                      setState(() {
                        _isAddingCity = true;
                      });
                      _addCity(_nameController.text);
                    },
              child: _isAddingCity
                  ? CustomProgressIndicator() // Utilisez le widget personnalisé ici
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

  void _addCity(String cityName) async {
    if (cityName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    final success = await CityService.addCity(cityName);

    setState(() {
      _isAddingCity = false;
    });

    _timer.cancel(); // Annuler le timer si la réponse est reçue avant le délai
    if (success == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ville ajoutée avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Échec de l'ajout de la ville")),
      );
    }
  }
}
