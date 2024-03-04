import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/costomeProgress.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:kairasahrl/widget/custometext.dart';
import 'package:http/http.dart' as http;

class ContainerAddScreen extends StatefulWidget {
  const ContainerAddScreen({Key? key});

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
  int _selectedStatus = 0; // 0: Inactif, 1: Actif
  int? _selectedContSizeID;
  int _selectedCityID = 0;
  bool _isFieldEmpty = false; // Initialement, le champ n'est pas vide
  List<Map<String, dynamic>> _cityData = [];
  final List<Map<String, dynamic>> _contSizeData = [
    {"id": 0, "name": "20 pieds"},
    {"id": 1, "name": "40 pieds"},
  ];

  @override
  void initState() {
    super.initState();
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load city data')),
      );
    }
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
          padding: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.indigo.shade100,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          labelText: 'Nom du Conteneur',
                          controller: _nameController,
                          isFieldEmpty: _isFieldEmpty,
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
                        const SizedBox(height: 9),
                        CustomTextField(
                          labelText: 'Client(e)',
                          controller: _customerController,
                          isFieldEmpty: _isFieldEmpty,
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
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    labelText: 'Téléphone',
                                    controller: _customerTelController,
                                    isFieldEmpty: _isFieldEmpty,
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Statut',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.indigo.shade900,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<int>(
                                      value: _selectedStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedStatus = value!;
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem<int>(
                                          value: 0,
                                          child: Text('Passif'),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 1,
                                          child: Text('Actif'),
                                        ),
                                      ],
                                      decoration:
                                          const InputDecoration(labelText: ''),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Courtier(e)',
                          controller: _brokerController,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    labelText: 'Téléphone du Courtier',
                                    controller: _brokerTelController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    labelText: 'Montant',
                                    controller: _amountController,
                                    isFieldEmpty: _isFieldEmpty,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ville',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.indigo.shade900,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<int>(
                                      value: _selectedCityID,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCityID = value!;
                                        });
                                      },
                                      items: _cityData.map((city) {
                                        return DropdownMenuItem<int>(
                                          value: city['id'],
                                          child: Text(city['name']),
                                        );
                                      }).toList(),
                                      decoration:
                                          const InputDecoration(labelText: ''),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Type de Conteneur',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.indigo.shade900,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<int>(
                                      value: _selectedContSizeID,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedContSizeID = value;
                                        });
                                      },
                                      items: _contSizeData.map((contSize) {
                                        return DropdownMenuItem<int>(
                                          value: contSize['id'],
                                          child: Text(contSize['name']),
                                        );
                                      }).toList(),
                                      decoration:
                                          const InputDecoration(labelText: ''),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Nouveau C',
                          controller: _newCController,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Détails du Conteneur',
                          controller: _contDetailsController,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 1, 55),
                      borderRadius: BorderRadius.circular(50)),
                  child: ElevatedButton(
                    style: buttonPrimary,
                    onPressed: () {
                      setState(() {
                        _isFieldEmpty = _nameController.text.isEmpty ||
                            _customerController.text.isEmpty ||
                            _customerTelController.text.isEmpty ||
                            _selectedStatus == null ||
                            _amountController.text.isEmpty ||
                            _selectedCityID == null ||
                            _selectedContSizeID == null;
                      });
                      if (!_isFieldEmpty) {
                        _addContainer();
                      }
                    },
                    child: _isAddingContainer
                        ? const CustomProgressIndicator()
                        : const Text(
                            'Ajouter',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
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

    final containerName = _nameController.text.trim();
    final customer = _customerController.text.trim();
    final customerTel = int.tryParse(_customerTelController.text.trim()) ?? 0;
    final broker = _brokerController.text.trim();
    final brokerTel = int.tryParse(_brokerTelController.text.trim()) ?? 0;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final newC = _newCController.text.trim();
    final contDetails = _contDetailsController.text.trim();
    final createdAt = DateTime.now().toIso8601String();

    if (containerName.isNotEmpty &&
        customer.isNotEmpty &&
        broker.isNotEmpty &&
        newC.isNotEmpty &&
        contDetails.isNotEmpty &&
        amount > 0) {
      final response = await http.post(
        Uri.parse('https://votre-api-url/containers'),
        body: json.encode({
          'name': containerName,
          'customer': customer,
          'customerTel': customerTel,
          'broker': broker,
          'brokerTel': brokerTel,
          'amount': amount,
          'newC': newC,
          'contDetails': contDetails,
          'cityID': _selectedCityID,
          'contTypeID': _selectedContSizeID,
          'status': _selectedStatus,
          'created_at': createdAt,
        }),
        headers: {'Content-Type': 'application/json'},
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de l\'ajout du conteneur')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }

    setState(() {
      _isAddingContainer = false;
    });
  }
}
