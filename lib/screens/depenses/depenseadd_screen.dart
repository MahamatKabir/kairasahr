import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class ArticlePaidField {
  TextEditingController articleController;
  TextEditingController paidController;

  ArticlePaidField()
      : articleController = TextEditingController(),
        paidController = TextEditingController();
}

class DepenseAddScreen extends StatefulWidget {
  const DepenseAddScreen({Key? key}) : super(key: key);

  @override
  State<DepenseAddScreen> createState() => _DepenseAddScreenState();
}

class _DepenseAddScreenState extends State<DepenseAddScreen> {
  final List<ArticlePaidField> _articleAndPaidFields = [];
  final TextEditingController _detailsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedContainerID;
  List<Conteneurre> _containerData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContainers();
    _addArticleAndPaidField(); // Ajouter le premier champ "article" et "paid" dès le début
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Conteneur',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
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
              ),
              const SizedBox(height: 20),
              // Affichage des champs "article" et "paid" ajoutés dynamiquement
              Column(
                children: _articleAndPaidFields.map((field) {
                  return _buildArticleAndPaidField(field);
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    labelText: 'Details',
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.indigo),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Vérifiez si le formulaire est valide
                    // Appel de votre méthode pour ajouter les dépenses
                    _addExpense();
                  }
                },
                child: const Text(
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

  // Ajoute un champ "article" et "paid"
  void _addArticleAndPaidField() {
    setState(() {
      _articleAndPaidFields.add(ArticlePaidField());
    });
  }

  Widget _buildArticleAndPaidField(ArticlePaidField field) {
    return Column(
      children: [
        const SizedBox(
          height: 22,
        ),
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
          child: Column(
            children: [
              TextFormField(
                controller: field.articleController,
                decoration: InputDecoration(
                  labelText: 'Article',
                  labelStyle: const TextStyle(color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: field.paidController,
                decoration: InputDecoration(
                  labelText: 'Paid',
                  labelStyle: const TextStyle(color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _addArticleAndPaidField();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Ajouter',
                      style: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                      textStyle: const TextStyle(color: Colors.white),
                      shadowColor: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.9),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _articleAndPaidFields.remove(field);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 197, 193),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                      textStyle: const TextStyle(color: Colors.white),
                      shadowColor: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.9),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Supprimer',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addExpense() async {
    try {
      // Liste pour stocker les données des champs "article" et "paid"
      List<Map<String, dynamic>> expenses = [];

      // Parcourir tous les champs "article" et "paid" ajoutés dynamiquement
      for (ArticlePaidField field in _articleAndPaidFields) {
        // Récupérer les valeurs de l'article et du montant
        String article = field.articleController.text.trim();
        int paid = int.tryParse(field.paidController.text) ?? 0;

        // Ajouter les données à la liste
        expenses.add({
          'article': article,
          'paid': paid,
          'containerID': _selectedContainerID,
        });
      }

      // Ajouter votre logique pour ajouter ces dépenses à l'API
      await AddExpenseService.createExpense(
        expenses: expenses,
        details: _detailsController.text,
      );

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dépenses ajoutées avec succès')),
      );
    } catch (e) {
      // Gérer les erreurs en cas d'échec de l'ajout
      print('Erreur lors de l\'ajout des dépenses: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'ajout des dépenses')),
      );
    }
  }
}
