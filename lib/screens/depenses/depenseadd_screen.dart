import 'package:flutter/material.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
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
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  int? _selectedContainerID;
  List<Map<String, dynamic>> _containerData = [];
  bool _isAddingExpense = false;

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
                      const Text(
                        'Conteneur',
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
                              child: Text(container['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedContainerID = value;
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
    // Appel de la méthode addExpense() de la classe AddExpenseService
    await AddExpenseService.addExpense(
      article: _articleController.text.trim(),
      total: int.tryParse(_totalController.text.trim()) ?? 0,
      paid: int.tryParse(_paidController.text.trim()) ?? 0,
      slug: _slugController.text.trim(),
      selectedContainerID: _selectedContainerID,
      context: context,
    );

    setState(() {
      _isAddingExpense = false;
    });
  }
}
