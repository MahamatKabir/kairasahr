import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class ContainerAddScreen extends StatefulWidget {
  const ContainerAddScreen({Key? key}) : super(key: key);

  @override
  State<ContainerAddScreen> createState() => _ContainerAddScreenState();
}

class _ContainerAddScreenState extends State<ContainerAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _customerTelController = TextEditingController();
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _brokerTelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCController = TextEditingController();
  final TextEditingController _contDetailsController = TextEditingController();
  bool _isAddingContainer = false;
  int? _selectedStatus; // 0: Inactif, 1: Actif
  int? _selectedContSizeID;
  int? _selectedCityID;
// Initialement, le champ n'est pas vide
  List<Map<String, dynamic>> _cityData = [];
  final List<Map<String, dynamic>> _contSizeData = [
    {"id": 0, "name": "20 pieds"},
    {"id": 1, "name": "40 pieds"},
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialiser les données de la ville
    _fetchCityData();
  }

  Future<void> _fetchCityData() async {
    try {
      final List<Map<String, dynamic>> cities =
          await ApiService.fetchCityData();
      setState(() {
        _cityData = cities;
        if (_cityData.isNotEmpty) _selectedCityID = _cityData[0]['id'];
      });
    } catch (e) {
      print('Error: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to load city data')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Fermez le clavier virtuel lorsque l'utilisateur clique en dehors du champ de texte
        FocusScope.of(context).unfocus();
        // Vérifiez si les champs nécessaires sont vides lorsque l'utilisateur clique en dehors
      },
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom du Container',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom du conteneur';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _customerController,
                  decoration: InputDecoration(
                    labelText: 'Client(e)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom du client';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _customerTelController,
                  decoration: InputDecoration(
                    labelText: 'Téléphone du Client',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le téléphone du client';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _brokerController,
                  decoration: InputDecoration(
                    labelText: 'Courtier(e)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _brokerTelController,
                  decoration: InputDecoration(
                    labelText: 'Téléphone du Courtier',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Montant',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                        items: const [
                          DropdownMenuItem<int>(
                            value: 0,
                            child: Text('Inactif'),
                          ),
                          DropdownMenuItem<int>(
                            value: 1,
                            child: Text('Actif'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Status',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner un statut';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedCityID,
                        onChanged: (value) {
                          setState(() {
                            _selectedCityID = value;
                          });
                        },
                        items: _cityData.map((city) {
                          return DropdownMenuItem<int>(
                            value: city['id'] as int,
                            child: Text(city['name'] as String),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Ville',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner une ville';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedContSizeID,
                        onChanged: (value) {
                          setState(() {
                            _selectedContSizeID = value;
                          });
                        },
                        items: _contSizeData.map((contSize) {
                          return DropdownMenuItem<int>(
                            value: contSize['id'] as int,
                            child: Text(contSize['name'] as String),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Type de conteneur',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner un type de conteneur';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _newCController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Nouveau C',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _contDetailsController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Détails du Conteneur',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addContainer();
                    }
                  },
                  style: buttonPrimary,
                  child: _isAddingContainer
                      ? const CircularProgressIndicator() // Afficher un indicateur de progression si l'ajout est en cours
                      : const Text(
                          'Ajouter',
                          style: TextStyle(color: Colors.white),
                        ), // Texte du bouton
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addContainer() async {
    setState(() {
      _isAddingContainer = true;
    });

    final String name = _nameController.text;
    final String customer = _customerController.text;
    final String customerTel = _customerTelController.text;
    final String broker = _brokerController.text;
    final String brokerTel = _brokerTelController.text;
    final String amount = _amountController.text;
    final String newC = _newCController.text;
    final String contDetails = _contDetailsController.text;

    final Map<String, dynamic> data = {
      'name': name,
      'customer': customer,
      'customerTel': customerTel,
      'broker': broker,
      'brokerTel': brokerTel,
      'amount': amount,
      'newC': newC,
      'contDetails': contDetails,
      'selectedCityID': _selectedCityID,
      'selectedContSizeID': _selectedContSizeID,
      'selectedStatus': _selectedStatus,
    };

    final Uri uri = Uri.parse('https://votre-api-url/containers');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(uri, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Conteneur ajouté avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add container');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: 'Échec de l\'ajout du conteneur',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isAddingContainer = false;
      });
    }
  }
}
