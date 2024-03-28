import 'package:flutter/material.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:http/http.dart' as http;
import 'package:kairasahrl/screens/depenses/expenselist.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class ExpenseDetailPage extends StatefulWidget {
  final Expenses expense;

  const ExpenseDetailPage({Key? key, required this.expense}) : super(key: key);

  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  bool isEditing = false;

  List<Conteneurre> _containerData = [];
  int? _selectedContainerID;
  bool _isLoading = false;

  // Controllers for required fields
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _amountPaidController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _createdby = TextEditingController();
  final TextEditingController _container = TextEditingController();
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load cities from API
    _fetchContainers();
    // Pre-fill controllers with existing values
    _articleController.text = widget.expense.article;
    _amountPaidController.text = widget.expense.amountPaid.toStringAsFixed(2);
    _detailsController.text = widget.expense.details ?? 'Non spécifié';
    _createdby.text = widget.expense.createdBy ?? 'Non spécifié';
    _date.text = widget.expense.createdAt ?? 'Non spécifié';
    _container.text = widget.expense.type?.name ?? 'Non spécifié';
  }

  // Fonction pour récupérer les conteneurs depuis l'API
  Future<void> _fetchContainers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Conteneurre> containers =
          await ContainerDepenseApi.fetchContainerDepense();
      setState(() {
        _containerData = containers;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load containers: $e');
      setState(() {
        _isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !isEditing ? Colors.indigo.shade100 : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 2, 95),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            isEditing ? 'Modifier          ' : 'Detail du Conteneur',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Text(
              isEditing ? 'Save' : 'Editer',
              style: TextStyle(
                fontSize: 18,
                color: isEditing ? Colors.green : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isEditing)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
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
                            controller: _articleController,
                            decoration: InputDecoration(
                              labelText: 'Article',
                              fillColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.indigo),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      if (isEditing)
                        const SizedBox(
                          height: 20,
                        ),
                      if (!isEditing)
                        _buildTextField('Article', _articleController,
                            required: true),
                      if (isEditing)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
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
                            controller: _amountPaidController,
                            decoration: InputDecoration(
                              labelText: 'Montant payé',
                              fillColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.indigo),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      if (isEditing)
                        const SizedBox(
                          height: 20,
                        ),
                      if (!isEditing)
                        _buildTextField('Montant payé', _amountPaidController,
                            required: true),
                      if (!isEditing)
                        _buildTextField('Conteneur', _container,
                            required: true),
                      if (isEditing)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'Conteneur',
                              labelStyle: const TextStyle(color: Colors.indigo),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            value: _selectedContainerID,
                            items: _containerData.map((container) {
                              return DropdownMenuItem<int>(
                                value: container.id,
                                child: Text(container.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedContainerID = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Veuillez sélectionner un conteneur';
                              }
                              return null;
                            },
                          ),
                        ),
                      if (isEditing)
                        const SizedBox(
                          height: 20,
                        ),
                      if (isEditing)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
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
                            controller: _detailsController,
                            decoration: InputDecoration(
                              labelText: 'Détails',
                              fillColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.indigo),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      if (isEditing)
                        const SizedBox(
                          height: 20,
                        ),
                      if (!isEditing)
                        _buildTextField('Détails', _detailsController,
                            required: true),
                      if (!isEditing)
                        _buildTextField('Creé par', _createdby, required: true),
                      if (!isEditing)
                        _buildTextField('Date de création ', _date,
                            required: true),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: isEditing,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () async {
                                if (_articleController.text.isEmpty ||
                                    _amountPaidController.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Champs requis'),
                                        content: const Text(
                                            'Veuillez remplir tous les champs obligatoires.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    isEditing = false;
                                    // Call the updateExpense method
                                    updateExpense();
                                  });
                                }
                              },
                              child: const Text(
                                'Mettre à jour',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: buttonDelete,
                              onPressed: () {
                                _confirmDelete(
                                    context, widget.expense.id.toString());
                              },
                              child: const Text(
                                'Supprimer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
          if (!isEditing)
            Text(
              label,
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          AnimatedContainer(
            height: 65,
            width:
                MediaQuery.of(context).size.width, // Utilisation de MediaQuery
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: isEditing ? Colors.white : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(1, 5),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Entrer $label',
                hintStyle: TextStyle(color: Colors.indigo.shade400),
              ),
              enabled: isEditing,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateExpense() async {
    // Build the expense object with updated values
    Expenses updatedExpense = Expenses(
      id: widget.expense.id,
      article: _articleController.text,
      amountPaid: double.parse(_amountPaidController.text),
    );

    try {
      // Call the API method to update the expense
      await AddExpenseService.updateExpense(updatedExpense);

      // If successful, navigate back to the ExpenseList screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpenseList()),
      );
    } catch (e) {
      print('Failed to update expense: $e');
      // Handle error appropriately
    }
  }
}
