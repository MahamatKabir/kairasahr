import 'package:flutter/material.dart';
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
  int? _selectedContainerID;
  bool _isFieldEmpty = false;
  List<Map<String, dynamic>> _containerData = [];

  final List<Widget> _repeaterItems = [];

  @override
  void initState() {
    super.initState();
    _fetchContainers(); // Appel de la fonction pour récupérer les conteneurs
    _repeaterItems.add(_buildRepeaterItem());
  }

  // Fonction pour récupérer les conteneurs depuis l'API
  void _fetchContainers() async {
    try {
      final List<Map<String, dynamic>> containers =
          await ApiService.fetchContainers();
      setState(() {
        _containerData = containers;
      });
    } catch (e) {
      print('Error fetching containers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Conteneur', // Texte de l'étiquette
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ' *', // Ajoute une étoile pour indiquer que le champ est requis
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(244, 67, 54, 1),
                    ), // Couleur rouge pour l'étoile
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
                        : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
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
            const SizedBox(height: 10),
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
                                elevation: 3, // Élévation du bouton
                                textStyle: const TextStyle(
                                    color: Colors.white), // Couleur du texte
                                shadowColor:
                                    const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.9), // Couleur de l'ombre
                              ),
                            ),
                            if (_repeaterItems.length >
                                1) // Affiche l'icône de suppression uniquement pour le dernier élément lorsque la liste contient plus d'un élément
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_repeaterItems.length > 1) {
                                      _repeaterItems.removeAt(i);
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 197, 193),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 3, // Élévation du bouton
                                  textStyle: const TextStyle(
                                      color: Colors.white), // Couleur du texte
                                  shadowColor: const Color.fromARGB(
                                          255, 255, 255, 255)
                                      .withOpacity(0.9), // Couleur de l'ombre
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: Colors.red), // Icône "remove"
                                    SizedBox(
                                        width:
                                            8), // Espace entre l'icône et le texte
                                    Text(
                                      'Supprimer',
                                      style: TextStyle(
                                          color:
                                              Colors.red), // Couleur du texte
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
              style: buttonPrimary,
              onPressed: () {
                setState(() {
                  _isFieldEmpty = _articleController.text.isEmpty ||
                      _selectedContainerID == null ||
                      _totalController.text.isEmpty ||
                      _paidController.text.isEmpty;
                });
                if (!_isFieldEmpty) {
                  _addExpense(
                    article: _articleController.text.trim(),
                    total: int.parse(_totalController.text),
                    paid: int.parse(_paidController.text),
                    selectedContainerID: _selectedContainerID!,
                  );
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
    );
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

  void _addExpense({
    required String article,
    required int total,
    required int paid,
    required int selectedContainerID,
  }) async {
    final slug =
        'your_slug_here'; // Remplacez "your_slug_here" par le slug approprié

    try {
      for (final item in _repeaterItems) {
        final Map<String, dynamic> itemData = {
          'article': article,
          'total': total,
          'paid': paid,
          'selectedContainerID': selectedContainerID,
          // Ajoutez d'autres données spécifiques de l'élément ici
        };

        await AddExpenseService.addExpense(
          itemData: itemData,
          slug: slug,
          context: context,
        );
      }
    } catch (e) {
      // Gérez les erreurs ici
      print('Error adding expense: $e');
    }
  }
}
