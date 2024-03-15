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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isAddingCity = false;
  late Timer _timer;
// Couleur initiale de boxShadow

  void _submitForm() {
    setState(() {
      _isAddingCity = true; // Activez l'indicateur de chargement
    });

    // Appelez votre fonction pour ajouter la ville avec le nom saisi dans le champ
    _addCity(_nameController.text);
  }

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
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Ville',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le nom de la ville';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Validez le formulaire
                                _submitForm();
                              }
                            },

                            child: _isAddingCity
                                ? const CustomProgressIndicator() // Utilisez le widget personnalisé ici
                                : const Text(
                                    'Ajouter',
                                    style: TextStyle(color: Colors.white),
                                  ), // Texte du bouton
                          ),
                        ],
                      ),
                    )),
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
