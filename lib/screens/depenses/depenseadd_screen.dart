import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class DepenseAddScreen extends StatefulWidget {
  const DepenseAddScreen({super.key});

  @override
  State<DepenseAddScreen> createState() => _DepenseAddScreenState();
}

class _DepenseAddScreenState extends State<DepenseAddScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _paidController =
      TextEditingController(); // Nouveau contrôleur pour le montant payé
  int _selectedContainerID = 0;
  final List<Map<String, dynamic>> _containerData = [];
  bool _isAddingExpense = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Article',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          controller: _articleController,
                          decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      // const Text(
                      //   'Slug:', // Nouvelle ligne ajoutée ici
                      //   style: TextStyle(fontSize: 10),
                      // ), // Nouvelle ligne ajoutée ici
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   height: 62,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white,
                      //   ),
                      //   child: TextField(
                      //     controller:
                      //         _slugController, // Ajout d'un nouveau controller pour Slug
                      //     decoration: const InputDecoration(
                      //       labelText: '',
                      //     ),
                      //   ),
                      // ),

                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          controller: _totalController,
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        'Paid', // Ajouter un champ pour le montant payé
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          controller: _paidController,
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Container',
                        style: TextStyle(fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
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
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
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
    );
  }

  void _addExpense() async {
    setState(() {
      _isAddingExpense = true;
    });

    final article = _articleController.text.trim();
    final total = int.tryParse(_totalController.text.trim()) ?? 0;
    final slug = _slugController.text.trim();
    // Récupération de la valeur du slug
    final paid = int.tryParse(_paidController.text.trim()) ??
        0; // Récupérer le montant payé
    final expenseId = _generateExpenseId(); // Automatically generate ID
    final createdAt = DateTime.now().toIso8601String();

    if (article.isNotEmpty && total > 0 && slug.isNotEmpty) {
      // final createdBy = _fetchContainerData(); // Fetch the user who created the expense

      final response = await http.post(
        Uri.parse('https://your-api-url/expenses'),
        body: json.encode({
          'id': expenseId,
          'article': article,
          'total': total,
          'paid': paid, // Ajouter le montant payé
          'slug': slug, // Ajout du slug dans les données envoyées
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

  String _generateExpenseId() {
    const uuid = Uuid();
    return uuid.v4(); // Génère un UUID v4 aléatoire
  }
}
