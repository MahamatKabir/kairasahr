import 'package:flutter/material.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:kairasahrl/widget/customer.dart';
import 'package:kairasahrl/widget/customermain.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameControllere = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _customerTelController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  bool _isAddingContainer = false;
  bool _isAddingCity = false;
  bool _isAddingExpense = false;
  int _selectedCityID = 0;
  int _selectedContTypeID = 0;
  int _selectedStatus = 0; // 0: Inactif, 1: Actif
  int _selectedContainerID = 0;
  List<Map<String, dynamic>> _cityData = [];
  List<Map<String, dynamic>> _contTypeData = [];
  List<Map<String, dynamic>> _containerData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CustomBackgroundContainer(
            title: 'AJOUTER',
            leadingIcon: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 41,
          ),
          Positioned(
            width: 348,
            height: 950,
            top: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(), // Pour le défilement par page
              child: Row(
                children: [
                  // Exemple d'un élément avec le nom "islam"
                  _buildItemWithLabel("Ville"),
                  _buildItemWithLabelContainer("Container"),
                  _buildItemWithLabelDepense("Depense"),
                  // Vous pouvez répéter cette méthode pour chaque élément de votre liste
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _buildItemWithLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10), // Espacement entre le label et l'élément
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            height: 600,
            width: 340,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 62,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xffC5C5C5),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(labelText: 'Nom de la Ville'),
                ),
              ),
              const SizedBox(
                height: 10,
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
            ]),
          ),

          //height: 100,
        ],
      ),
    );
  }

  Widget _buildItemWithLabelContainer(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10), // Espacement entre le label et l'élément
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            height: 600,
            width: 340,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 62,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: TextField(
                        controller: _nameControllere,
                        decoration: const InputDecoration(
                          labelText: 'Nom du Conteneur',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 300,
                      height: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: TextField(
                        controller: _customerController,
                        decoration: const InputDecoration(labelText: 'Client'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 62,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: TextField(
                        controller: _customerTelController,
                        decoration: const InputDecoration(
                            labelText: 'Téléphone du Client'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: 300,
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color(0xffC5C5C5),
                              ),
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
                                  const InputDecoration(labelText: 'Ville'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: 300,
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: const Color(0xffC5C5C5),
                              ),
                            ),
                            child: DropdownButtonFormField<int>(
                              value: _selectedContTypeID,
                              onChanged: (value) {
                                setState(() {
                                  _selectedContTypeID = value!;
                                });
                              },
                              items: _contTypeData.map((contType) {
                                return DropdownMenuItem<int>(
                                  value: contType['id'],
                                  child: Text(contType['name']),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                  labelText: 'Type de conteneur'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 300,
                      height: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
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
                        decoration: const InputDecoration(labelText: 'Statut'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: buttonPrimary,
                      onPressed: _isAddingContainer ? null : _addContainer,
                      child: _isAddingContainer
                          ? const CircularProgressIndicator()
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
        ],
      ),
    );
  }

  Widget _buildItemWithLabelDepense(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),

          // Espacement entre le label et l'élément

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            height: 600,
            width: 340,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 62,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: TextField(
                        controller: _articleController,
                        decoration: const InputDecoration(labelText: 'Article'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 62,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: TextField(
                        controller: _totalController,
                        decoration: const InputDecoration(labelText: 'Total'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 62,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xffC5C5C5),
                        ),
                      ),
                      child: DropdownButtonFormField<int>(
                        decoration:
                            const InputDecoration(labelText: 'Container'),
                        value: _selectedContainerID,
                        items: _containerData.map((container) {
                          return DropdownMenuItem<int>(
                            value: container['id'],
                            child: Text(container[
                                'name']), // Assuming 'name' field exists
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedContainerID = value!;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: buttonPrimary,
                      onPressed: _isAddingExpense ? null : _addExpense,
                      child: _isAddingExpense
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Ajouter',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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

  void _fetchCityAndContType() async {
    final cityResponse =
        await http.get(Uri.parse('https://votre-api-url/cities'));
    final contTypeResponse =
        await http.get(Uri.parse('https://votre-api-url/contTypes'));

    if (cityResponse.statusCode == 200 && contTypeResponse.statusCode == 200) {
      _cityData =
          List<Map<String, dynamic>>.from(json.decode(cityResponse.body));
      _contTypeData =
          List<Map<String, dynamic>>.from(json.decode(contTypeResponse.body));

      setState(() {
        if (_cityData.isNotEmpty) _selectedCityID = _cityData[0]['id'];
        if (_contTypeData.isNotEmpty)
          _selectedContTypeID = _contTypeData[0]['id'];
      });
    }
  }

  void _addContainer() async {
    setState(() {
      _isAddingContainer = true;
    });

    final containerName = _nameControllere.text.trim();
    final containerSlug = _slugController.text.trim();
    final customer = _customerController.text.trim();
    final customerTel = _customerTelController.text.trim();
    final containerId = _generateContainerId();
    final createdAt = DateTime.now().toIso8601String();

    if (containerName.isNotEmpty &&
        containerSlug.isNotEmpty &&
        customer.isNotEmpty &&
        customerTel.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://votre-api-url/containers'),
        body: json.encode({
          'id': containerId,
          'name': containerName,
          'slug': containerSlug,
          'customer': customer,
          'customerTel': customerTel,
          'cityID': _selectedCityID,
          'contTypeID': _selectedContTypeID,
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

  void _addExpense() async {
    setState(() {
      _isAddingExpense = true;
    });

    final article = _articleController.text.trim();
    final total = int.tryParse(_totalController.text.trim()) ?? 0;
    final expenseId = _generateExpenseId(); // Automatically generate ID
    final createdAt = DateTime.now().toIso8601String();

    if (article.isNotEmpty && total > 0) {
      //final   createdBy = _fetchContainerData(); // Fetch the user who created the expense

      final response = await http.post(
        Uri.parse('https://your-api-url/expenses'),
        body: json.encode({
          'id': expenseId,
          'article': article,
          'total': total,
          // 'created_by': createdBy, // Passing createdBy ID
          'created_at': createdAt,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Expense added successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add expense')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }

    setState(() {
      _isAddingExpense = false;
    });
  }

  // Future<int> _fetchContainerData() async {
  //   final response =
  //       await http.get(Uri.parse('https://votre-api-url/container'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _containerData =
  //           List<Map<String, dynamic>>.from(json.decode(response.body));
  //       if (_containerData.isNotEmpty) {
  //         _selectedContainerID = _containerData[0]['id'];
  //       }
  //     });
  //   }
  // }

  String _generateContainerId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  String _generateCityId() {
    const uuid = Uuid();
    return uuid.v4(); // Génère un UUID v4 aléatoire
  }

  String _generateExpenseId() {
    const uuid = Uuid();
    return uuid.v4(); // Génère un UUID v4 aléatoire
  }
}
