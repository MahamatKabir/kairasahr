import 'package:flutter/material.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class DepenseAddScreen extends StatefulWidget {
  const DepenseAddScreen({Key? key}) : super(key: key);

  @override
  State<DepenseAddScreen> createState() => _DepenseAddScreenState();
}

class _DepenseAddScreenState extends State<DepenseAddScreen> {
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedContainerID;
  List<Conteneurre> _containerData = [];
  bool _isLoading = false;

  final List<Widget> _repeaterItems = [];

  @override
  void initState() {
    super.initState();
    _fetchContainers(); // Appel de la fonction pour récupérer les conteneurs
    _repeaterItems.add(_buildRepeaterItem());
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

  Widget _buildRepeaterItem() {
    TextEditingController articleController = TextEditingController();
    TextEditingController totalController = TextEditingController();
    TextEditingController paidController = TextEditingController();

    return Container(
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
            controller: articleController,
            decoration: InputDecoration(
              labelText: 'Article',
              labelStyle: const TextStyle(color: Colors.indigo),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: totalController,
                  decoration: InputDecoration(
                    labelText: 'Total',
                    labelStyle: const TextStyle(color: Colors.indigo),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: paidController,
                  decoration: InputDecoration(
                    labelText: 'Paid',
                    labelStyle: const TextStyle(color: Colors.indigo),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
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
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < _repeaterItems.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _repeaterItems[i],
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _repeaterItems.add(_buildRepeaterItem());
                                  });
                                },
                                icon: const Icon(Icons.add),
                                label: const Text(
                                  'Ajouter',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 3,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  shadowColor:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.9),
                                ),
                              ),
                              if (_repeaterItems.length > 1)
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_repeaterItems.length > 1) {
                                        _repeaterItems.removeAt(i);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 197, 193),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 3,
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                    shadowColor:
                                        const Color.fromARGB(255, 255, 255, 255)
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
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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

  void _addExpense() async {
    try {
      for (var item in _repeaterItems) {
        if (item is Container) {
          // Accédez au widget enfant du Container
          Widget? containerChild = item.child;

          if (containerChild is Column) {
            // Accédez aux enfants de la colonne
            List<Widget> columnChildren = containerChild.children;

            // Vérifiez si la colonne a au moins 3 enfants
            if (columnChildren.length >= 3) {
              // Extraire les contrôleurs de texte des enfants
              TextEditingController? articleController;
              TextEditingController? totalController;
              TextEditingController? paidController;

              for (var child in columnChildren) {
                if (child is TextFormField) {
                  if (articleController == null) {
                    articleController =
                        child.controller as TextEditingController;
                  } else if (totalController == null) {
                    totalController = child.controller as TextEditingController;
                  } else
                    paidController ??=
                        child.controller as TextEditingController;
                }
              }

              // Vérifier si les contrôleurs de texte ont été correctement initialisés
              if (articleController != null &&
                  totalController != null &&
                  paidController != null) {
                // Extraire les valeurs des contrôleurs de texte
                String article = articleController.text.trim();
                int total = int.parse(totalController.text);
                int paid = int.parse(paidController.text);

                // Ajouter votre logique pour ajouter cette dépense à l'API
                await AddExpenseService.createExpense(
                  article: article,
                  total: total,
                  paid: paid,
                  containerID: _selectedContainerID!,
                );
              } else {
                // Afficher un message d'erreur si les contrôleurs de texte n'ont pas été correctement initialisés
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Erreur lors de la récupération des données de dépense'),
                  ),
                );
                return; // Arrêtez le processus pour éviter toute autre erreur
              }
            } else {
              // Afficher un message d'erreur si la colonne n'a pas suffisamment d'enfants
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Erreur lors de la récupération des données de dépense'),
                ),
              );
              return; // Arrêtez le processus pour éviter toute autre erreur
            }
          }
        }
      }
    } catch (e) {
      // Gérer les erreurs en cas d'échec de l'ajout
      print('Erreur lors de l\'ajout de la dépense: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'ajout de la dépense')),
      );
    }
  }
}
