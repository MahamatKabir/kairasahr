import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/costomeProgress.dart';
import 'package:kairasahrl/widget/button.dart';

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

  @override
  void initState() {
    super.initState();
    _timer =
        Timer(const Duration(seconds: 0), () {}); // Initialisation de _timer
  }

  @override
  void dispose() {
    _timer
        .cancel(); // Assurez-vous d'annuler le timer lors de la suppression de l'écran
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _isAddingCity = true; // Activez l'indicateur de chargement
    });

    // Appelez votre fonction pour ajouter la ville avec le nom saisi dans le champ
    _addCity(_nameController.text);
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
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
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                            child: _isAddingCity
                                ? const CustomProgressIndicator()
                                : const Text(
                                    'Ajouter',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
    setState(() {
      _isAddingCity = true; // Activer l'indicateur d'ajout
    });

    final success = await CityService.addCity(cityName);
    if (success != 'success') {
      Fluttertoast.showToast(
        msg: 'Ville ajoutée avec succès',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      _nameController.text = '';
      FocusScope.of(context).unfocus();
    } else {
      Fluttertoast.showToast(
        msg: "Échec de l'ajout de la ville",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    setState(() {
      _isAddingCity = false; // Désactiver l'indicateur d'ajout
    });
  }
}
