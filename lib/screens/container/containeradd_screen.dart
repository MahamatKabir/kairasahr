import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ContainerAddScreen extends StatefulWidget {
  const ContainerAddScreen({super.key});

  @override
  State<ContainerAddScreen> createState() => _ContainerAddScreenState();
}

class _ContainerAddScreenState extends State<ContainerAddScreen> {
  final TextEditingController _nameControllere = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _customerTelController = TextEditingController();
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _brokerTelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCController = TextEditingController();
  final TextEditingController _contDetailsController = TextEditingController();
  bool _isAddingContainer = false;
  int _selectedStatus = 0; // 0: Inactif, 1: Actif
  int _selectedContSizeID = 1;
  int _selectedCityID = 0;
  List<Map<String, dynamic>> _cityData = [];
  final List<Map<String, dynamic>> _contSizeData = [
    {"id": 1, "name": "20 pieds"},
    {"id": 2, "name": "40 pieds"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.indigo.shade50,
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
                      const Text(
                        'Nom du Container',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
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
                          controller: _nameControllere,
                          decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'Client',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          controller: _customerController,
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Téléphone',
                                style: TextStyle(fontSize: 13),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                  controller: _customerTelController,
                                  decoration: const InputDecoration(
                                      labelText: '', border: InputBorder.none),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Statut',
                                  style: TextStyle(fontSize: 13),
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
                                        child: Text('Inactif'),
                                      ),
                                      DropdownMenuItem<int>(
                                        value: 1,
                                        child: Text('Actif'),
                                      ),
                                    ],
                                    decoration: const InputDecoration(
                                        labelText: '',
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Courtier',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          controller: _brokerController,
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Téléphone du Courtier',
                                style: TextStyle(fontSize: 13),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                  controller: _brokerTelController,
                                  decoration: const InputDecoration(
                                      labelText: '', border: InputBorder.none),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Montant',
                                style: TextStyle(fontSize: 13),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                  controller: _amountController,
                                  decoration: const InputDecoration(
                                      labelText: '', border: InputBorder.none),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ville:',
                                  style: TextStyle(fontSize: 13),
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
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Type de Container:',
                                  style: TextStyle(fontSize: 13),
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
                                        _selectedContSizeID = value!;
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
                      const Text(
                        'Nouveau C',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 60,
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
                          controller: _newCController,
                          decoration: const InputDecoration(labelText: ''),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Détails du Container',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
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
                          controller: _contDetailsController,
                          decoration: const InputDecoration(labelText: ''),
                          maxLines: null,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Container(
                width: 350,
                //color: const Color.fromARGB(255, 1, 1, 55),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 1, 55),
                    borderRadius: BorderRadius.circular(50)),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: _isAddingContainer ? null : _addContainer,
                  child: _isAddingContainer
                      ? const CircularProgressIndicator()
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
    );
  }

  void _addContainer() async {
    setState(() {
      _isAddingContainer = true;
    });

    final containerName = _nameControllere.text.trim();
    final customer = _customerController.text.trim();
    final customerTel = int.parse(_customerTelController.text.trim());
    final broker = _brokerController.text.trim();
    final brokerTel = int.parse(_brokerTelController.text.trim());
    final amount = double.parse(_amountController.text.trim());
    final newC = _newCController.text.trim();
    final contDetails = _contDetailsController.text.trim();
    final createdAt = DateTime.now().toIso8601String();

    if (containerName.isNotEmpty &&
        customer.isNotEmpty &&
        broker.isNotEmpty &&
        newC.isNotEmpty &&
        contDetails.isNotEmpty) {
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
          'contTypeID':
              _selectedContSizeID, // Utilise _selectedContSizeID pour l'ID du type de conteneur sélectionné
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

  void _fetchCityAndContType() async {
    final cityResponse =
        await http.get(Uri.parse('https://votre-api-url/cities'));
    final contTypeResponse =
        await http.get(Uri.parse('https://votre-api-url/contTypes'));

    if (cityResponse.statusCode == 200 && contTypeResponse.statusCode == 200) {
      _cityData =
          List<Map<String, dynamic>>.from(json.decode(cityResponse.body));

      setState(() {
        if (_cityData.isNotEmpty) _selectedCityID = _cityData[0]['id'];
      });
    }
  }

  String _generateContainerId() {
    const uuid = Uuid();
    return uuid.v4();
  }
}
