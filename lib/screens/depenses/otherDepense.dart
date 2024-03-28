import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class ArticlePaidField {
  TextEditingController articleController;
  TextEditingController paidController;

  ArticlePaidField()
      : articleController = TextEditingController(),
        paidController = TextEditingController();
}

class AuthDepenseAddScreen extends StatefulWidget {
  const AuthDepenseAddScreen({Key? key}) : super(key: key);

  @override
  State<AuthDepenseAddScreen> createState() => _AuthDepenseAddScreenState();
}

class _AuthDepenseAddScreenState extends State<AuthDepenseAddScreen> {
  final List<ArticlePaidField> _articleAndPaidFields = [];
  final TextEditingController _detailsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addArticleAndPaidField(); // Ajouter le premier champ "article" et "paid" dès le début
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    maxLines: 2,
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
        const SizedBox(height: 22),
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
              const SizedBox(height: 15),
              TextFormField(
                controller: field.paidController,
                decoration: InputDecoration(
                  labelText: 'Payé',
                  labelStyle: const TextStyle(color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
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
                  if (_articleAndPaidFields.length > 1)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_articleAndPaidFields.length > 1) {
                            _articleAndPaidFields.remove(field);
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
      List<Map<String, dynamic>> contExpenses = [];

      for (ArticlePaidField field in _articleAndPaidFields) {
        // Récupérer les valeurs de l'article et du montant
        String article = field.articleController.text.trim();
        int paid = int.tryParse(field.paidController.text) ?? 0;

        // Vérifier si les champs sont vides
        if (article.isEmpty || paid == 0) {
          // Afficher un message d'erreur et arrêter le processus d'ajout
          Fluttertoast.showToast(
            msg: 'Veuillez remplir tous les champs',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return; // Arrêter la fonction _addExpense()
        }

        // Ajouter les données à la liste
        contExpenses.add({
          'article': article,
          'paid': paid,
        });
      }

      // Ajouter votre logique pour ajouter ces dépenses à l'API
      await AddExpenseService.createAuthExpense(
        contExpenses: contExpenses,
        details: _detailsController.text,
      );

      // Afficher un message de succès
    } catch (e) {
      // Gérer les erreurs en cas d'échec de l'ajout
      print('Erreur lors de l\'ajout des dépenses: $e');
    }
  }
}
