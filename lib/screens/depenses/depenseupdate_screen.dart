import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/button.dart';

class DepenseUpScreen extends StatefulWidget {
  static const routeName = "/DepenseUpScreen";
  final Expense expense;
  final Function(int) onDelete;
  final Function(
    int,
    String,
    String,
    int,
    int,
    int,
    int,
    String,
    int,
    String,
  ) onUpdate;

  const DepenseUpScreen({
    Key? key,
    required this.expense,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _DepenseUpScreenState createState() => _DepenseUpScreenState();
}

class _DepenseUpScreenState extends State<DepenseUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final TextEditingController _containerIDController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _updatedByController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();

  bool _isEditing = false;

  // Define a list to hold dropdown items
  List<DropdownMenuItem<String>> _dropdownItems = [];

  // Define a variable to hold the selected dropdown value
  String? _selectedContainerID;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _fetchContainerIDs(); // Fetch container IDs when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !_isEditing ? Colors.indigo.shade100 : Colors.white,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 0, 66),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Center(
            child: Text(
              _isEditing ? 'Modifier' : 'Dépense detail',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextButton(
                  onPressed: () {
                    if (_isEditing) {
                      _updateExpense(); // Mise à jour si en mode édition
                    } else {
                      setState(() {
                        _isEditing = !_isEditing; // Inverser l'état d'édition
                      });
                    }
                  },
                  child: Text(
                    _isEditing ? 'Save' : 'Éditer',
                    style: TextStyle(
                      fontSize: 15,
                      color: _isEditing ? Colors.green : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      color:
                          !_isEditing ? Colors.indigo.shade100 : Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTextFieldWithBorder(
                              'Article',
                              _nameController,
                              _isEditing,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            _buildTextFieldWithBorder(
                                'Total', _totalController, _isEditing),
                            const SizedBox(
                              height: 2,
                            ),
                            _buildTextFieldWithBorder(
                                'Payé', _paidController, _isEditing),
                            const SizedBox(
                              height: 2,
                            ),
                            _isEditing
                                ? _buildContainerDropdown()
                                : _buildTextFieldWithBorder(
                                    'Conteneur',
                                    _containerIDController,
                                    _isEditing,
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!_isEditing)
                              _buildTextFieldWithBorder(
                                  'Creér par', _createdByController, false),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!_isEditing)
                              _buildTextFieldWithBorder('Date de creation',
                                  _createdAtController, false),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: _isEditing,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: ElevatedButton(
                                      style: buttonDelete,
                                      onPressed: () {
                                        widget.onDelete(widget.expense.id);
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: 'Depense supprimer avec succée',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                        );
                                      },
                                      child: const Text(
                                        'Supprimer',
                                        style: TextStyle(color: Colors.white),
                                      ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildContainerDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conteneur',
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: _isEditing ? Colors.white : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedContainerID,
              items: _dropdownItems,
              onChanged: (String? value) {
                setState(() {
                  _selectedContainerID = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '',
                hintStyle: TextStyle(color: Colors.indigo.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithBorder(
      String label, TextEditingController controller, bool enabled) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: _isEditing ? Colors.white : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
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
                hintText: 'Enter $label',
                hintStyle: TextStyle(color: Colors.indigo.shade400),
              ),
              enabled: _isEditing,
            ),
          ),
        ],
      ),
    );
  }

  void _initializeControllers() {
    _nameController.text = widget.expense.article;
    _slugController.text = widget.expense.slug;
    _totalController.text = widget.expense.total.toString();
    _paidController.text = widget.expense.paid.toString();
    _containerIDController.text = widget.expense.containerID.toString();
    _createdByController.text = widget.expense.createdBy.toString();
    _createdAtController.text = widget.expense.createdAt;
    _updatedByController.text = widget.expense.updatedBy.toString();
    _updatedAtController.text = widget.expense.updatedAt.toString();
  }

  void _updateExpense() {
    // Vérifier que le champ "Article" n'est pas vide
    if (_nameController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Article field cannot be empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return; // Sortir de la fonction si le champ est vide
    }

    // Vérifier que les champs total et paid ne sont ni nulls ni vides
    if (_totalController.text.isEmpty || _paidController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Total and Paid fields cannot be empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return; // Sortir de la fonction si les champs sont vides
    }

    // Vérifier que les valeurs de total et paid ne sont pas inférieures à 0
    int? total = int.tryParse(_totalController.text);
    int? paid = int.tryParse(_paidController.text);

    if (total == null || paid == null || total < 0 || paid < 0) {
      Fluttertoast.showToast(
        msg: 'Total and Paid values must be valid positive integers',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return; // Sortir de la fonction si les valeurs sont invalides
    }

    // Vérifier si le champ containerID est null ou vide
    String containerID = _selectedContainerID ?? _containerIDController.text;
    if (containerID.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Container ID cannot be empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return; // Sortir de la fonction si le champ est invalide
    }

    // Mettre à jour l'Expense
    widget.onUpdate(
      widget.expense.id,
      _nameController.text,
      _slugController.text,
      total,
      paid,
      int.parse(containerID),
      int.tryParse(_createdByController.text) ?? 0,
      _createdAtController.text,
      int.tryParse(_updatedByController.text) ?? 0,
      _updatedAtController.text,
    );

    // Si la mise à jour s'est déroulée avec succès, inverser l'état d'édition
    setState(() {
      _isEditing = !_isEditing;
    });

    Fluttertoast.showToast(
      msg: 'Updated Successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  // Fetch Container IDs from API
  void _fetchContainerIDs() async {
    try {
      // Make API call to fetch container IDs
      List<String> containerIDs = await YourApi.fetchContainerIDs();

      // Update dropdown items with fetched container IDs
      setState(() {
        _dropdownItems = containerIDs.map((String containerID) {
          return DropdownMenuItem<String>(
            value: containerID,
            child: Text(containerID),
          );
        }).toList();
      });
    } catch (e) {
      print("Error fetching container IDs: $e");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _totalController.dispose();
    _paidController.dispose();
    _containerIDController.dispose();
    _createdByController.dispose();
    _createdAtController.dispose();
    _updatedByController.dispose();
    _updatedAtController.dispose();
    super.dispose();
  }
}
