import 'package:flutter/material.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/costomeProgress.dart';
import 'package:kairasahrl/widget/button.dart';
import '../../widget/custometext.dart';

class DepenseAddScreen extends StatefulWidget {
  const DepenseAddScreen({Key? key}) : super(key: key);

  @override
  State<DepenseAddScreen> createState() => _DepenseAddScreenState();
}

class _DepenseAddScreenState extends State<DepenseAddScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  int? _selectedContainerID;
  List<Map<String, dynamic>> _containerData = [];
  bool _isAddingExpense = false;
  bool _isFieldEmpty = false; // Initialement, le champ n'est pas vide

  @override
  void initState() {
    super.initState();
    _fetchContainerData();
  }

  Future<void> _fetchContainerData() async {
    try {
      _containerData = await ApiService.fetchContainers();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load container data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        labelText: 'Article',
                        controller: _articleController,
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
                        labelText: 'Total',
                        controller: _totalController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 9),
                      CustomTextField(
                        labelText: 'Payé',
                        controller: _paidController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 9),
                      Text(
                        'Conteneur',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
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
                        ),
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                          ),
                          value: _selectedContainerID,
                          items: _containerData.map((container) {
                            return DropdownMenuItem<int>(
                              value: container['id'],
                              child: Text(container['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedContainerID = value;
                              _isFieldEmpty = _selectedContainerID == null;
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
                onPressed: () {
                  setState(() {
                    _isFieldEmpty = _articleController.text.isEmpty ||
                        _selectedContainerID == null;
                  });
                  if (!_isFieldEmpty) {
                    _addExpense(
                      article: _articleController.text.trim(),
                      selectedContainerID: _selectedContainerID!,
                    );
                  }
                },
                child: _isAddingExpense
                    ? const CustomProgressIndicator()
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

  void _addExpense({
    required String article,
    int? total,
    int? paid,
    String? slug,
    int? selectedContainerID,
  }) async {
    setState(() {
      _isAddingExpense = true;
    });
    if (article.isEmpty || selectedContainerID == null) {
      setState(() {
        _isAddingExpense = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article et Conteneur sont obligatoires.'),
        ),
      );
      return;
    }
    // Appel de la méthode addExpense() de la classe AddExpenseService
    await AddExpenseService.addExpense(
      article: article,
      total: total ?? 0,
      paid: paid ?? 0,
      slug: slug ?? '',
      selectedContainerID: selectedContainerID,
      context: context,
    );

    setState(() {
      _isAddingExpense = false;
    });
  }
}
