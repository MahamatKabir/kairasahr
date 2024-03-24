import 'package:flutter/material.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:http/http.dart' as http;
import 'package:kairasahrl/screens/depenses/expenselist.dart';
import 'package:kairasahrl/screens/fetchapi.dart';

class ExpenseDetailPage extends StatefulWidget {
  final Expenses expense;

  const ExpenseDetailPage({Key? key, required this.expense}) : super(key: key);

  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  bool isEditing = false;
  List<Map<String, dynamic>> _cityData = [];
  int? _selectedCity;

  // Controllers for required fields
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _amountPaidController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load cities from API
    _fetchCityData();

    // Pre-fill controllers with existing values
    _articleController.text = widget.expense.article;
    _amountPaidController.text = widget.expense.amountPaid.toString();
    _detailsController.text = widget.expense.details;
  }

  Future<void> deleteExpense(String id) async {
    final response = await http.delete(
      Uri.parse('http://kairasarl.yerimai.com/api/v1/expenses/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpenseList()),
      );
    } else {
      throw Exception('Failed to delete expense');
    }
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez-vous vraiment supprimer cette dépense ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteExpense(id);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchCityData() async {
    try {
      final List<Map<String, dynamic>> cities =
          await ApiService.fetchCityData();
      setState(() {
        _cityData = cities;
        if (_cityData.isNotEmpty) {
          _selectedCity = _cityData[0]['id'];
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la dépense'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Article', _articleController, required: true),
                _buildTextField('Montant payé', _amountPaidController,
                    required: true),
                if (isEditing)
                  DropdownButtonFormField<int>(
                    value: _selectedCity,
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    items: _cityData.map((city) {
                      return DropdownMenuItem<int>(
                        value: city['id'] as int,
                        child: Text(city['name'] as String),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez sélectionner une ville';
                      }
                      return null;
                    },
                  ),
                _buildTextField('Détails', _detailsController, required: true),
                const SizedBox(height: 16),
                Visibility(
                  visible: isEditing,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_articleController.text.isEmpty ||
                              _amountPaidController.text.isEmpty ||
                              _detailsController.text.isEmpty ||
                              _selectedCity == null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Champs requis'),
                                  content: Text(
                                      'Veuillez remplir tous les champs obligatoires.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            setState(() {
                              isEditing = false;
                              // Perform update operation here
                            });
                          }
                        },
                        child: const Text('Mettre à jour'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _confirmDelete(context, widget.expense.id.toString());
                        },
                        child: const Text('Supprimer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {required bool required}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            enabled: isEditing,
            controller: controller,
            validator: (value) {
              if (required && value!.isEmpty) {
                return 'Ce champ est requis';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
