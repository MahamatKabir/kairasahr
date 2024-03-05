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
// Couleur initiale de boxShadow

  @override
  void dispose() {
    _timer
        .cancel(); // Assurez-vous d'annuler le timer lors de la suppression de l'écran
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Fermez le clavier virtuel lorsque l'utilisateur clique en dehors du champ de texte
        FocusScope.of(context).unfocus();
        // Vérifie si le champ de texte est vide lorsqu'on clique en dehors du champ
        if (_nameController.text.isEmpty) {
          setState(() {
            _isFieldEmpty = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.indigo.shade100,
          ),
          child: SingleChildScrollView(
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
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Nom du ville', // Texte de l'étiquette
                              style: TextStyle(
                                  fontSize: 13, color: Colors.indigo.shade900),
                            ),
                            const TextSpan(
                              text:
                                  ' *', // Ajoute une étoile pour indiquer que le champ est requis
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors
                                      .red), // Couleur rouge pour l'étoile
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: _isFieldEmpty
                                  ? Colors.red.withOpacity(0.7)
                                  : const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4.0),
                          border: _isFieldEmpty
                              ? Border.all(
                                  color: Color.fromARGB(255, 249, 228, 226),
                                  width: 2.0)
                              : null,
                        ),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            errorText: _isFieldEmpty
                                ? 'Ce champ est obligatoire'
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _isFieldEmpty =
                                    false; // Set _isFieldEmpty to false if the field becomes empty
                              } else {
                                _isFieldEmpty = value.isEmpty;
                              }
                            });
                          },
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
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      setState(() {
                        _isFieldEmpty = true;
                      });
                    } else {
                      _timer = Timer(Duration(seconds: 5), () {
                        setState(() {
                          _isAddingCity = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Délai dépassé. Veuillez réessayer.'),
                          ),
                        );
                      });
                      setState(() {
                        _isAddingCity = true;
                      });
                      _addCity(_nameController.text);
                    }
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
