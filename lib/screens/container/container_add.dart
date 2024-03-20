import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class CreateContainerPage extends StatefulWidget {
  const CreateContainerPage({super.key});

  @override
  _CreateContainerPageState createState() => _CreateContainerPageState();
}

class _CreateContainerPageState extends State<CreateContainerPage> {
  final TextEditingController containerNameController = TextEditingController();
  final TextEditingController containerInformationController =
      TextEditingController();
  final TextEditingController containerPlateNoController =
      TextEditingController();
  final TextEditingController containerPriceController =
      TextEditingController();
  final TextEditingController containerCityIdController =
      TextEditingController();
  final TextEditingController containerOtherDetailsController =
      TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController brokerNameController = TextEditingController();
  final TextEditingController brokerPhoneController = TextEditingController();
  int selectedStatus = 1;
  int selectedContainerType = 1;
  bool _isAddingContainer = false;
  List<Map<String, dynamic>> _cityData = [];
  int? _selectedCityID;
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

  Future<void> createContainer() async {
    var url = Uri.parse('http://kairasarl.yerimai.com/api/v1/containers');
    try {
      var response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'container_name': containerNameController.text,
          'container_information_c': containerInformationController.text,
          'container_plate_no': containerPlateNoController.text,
          'container_price': containerPriceController.text,
          'container_type': selectedContainerType.toString(),
          'container_city_id': _selectedCityID.toString(),
          'container_other_details': containerOtherDetailsController.text,
          'customer_name': customerNameController.text,
          'costumer_phone': customerPhoneController.text,
          'broker_name': brokerNameController.text,
          'broker_phone': brokerPhoneController.text,
          'status': selectedStatus.toString(),
        },
      );
      if (response.statusCode != 200) {
        Fluttertoast.showToast(
          msg: "Container created successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to create container. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isAddingContainer = false; // Désactiver l'indicateur de progression
      });
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
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.indigo.shade100,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: containerNameController,
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
                      controller: containerPlateNoController,
                      decoration: InputDecoration(
                        labelText: 'Plaque',
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
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: customerNameController,
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
                      controller: customerPhoneController,
                      keyboardType: TextInputType.number,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: containerPriceController,
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
                            value: selectedContainerType,
                            onChanged: (value) {
                              setState(() {
                                selectedContainerType = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: 1, child: Text('20 Pieds')),
                              DropdownMenuItem(
                                  value: 2, child: Text('40 Pieds')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Container Type',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
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
                            }).toList(), // Ajoutez une vérification de nullité pour _cityData
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
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: selectedStatus,
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(value: 1, child: Text('Active')),
                              DropdownMenuItem(
                                  value: 2, child: Text('Passive')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Status',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: brokerNameController,
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
                      controller: brokerPhoneController,
                      keyboardType: TextInputType.number,
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
                    TextFormField(
                      controller: containerInformationController,
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
                      controller: containerOtherDetailsController,
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
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isAddingContainer =
                                true; // Activer l'indicateur de progression
                          });
                          createContainer(); // Appeler la fonction pour créer le conteneur
                        }
                      },
                      style: buttonPrimary,
                      child: _isAddingContainer
                          ? const CircularProgressIndicator() // Afficher l'indicateur de progression lors du clic
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
        ),
      ),
    );
  }
}
