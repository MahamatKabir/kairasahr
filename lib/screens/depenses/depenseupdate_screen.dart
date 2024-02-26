import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:kairasahrl/widget/customer.dart';

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

  bool _isUpdatingExpense = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HeroIcon(
                _isEditing ? HeroIcons.check : HeroIcons.queueList,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      color: Colors.indigo.shade50,
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
                                'Paid', _paidController, _isEditing),
                            const SizedBox(
                              height: 2,
                            ),
                            _buildTextFieldWithBorder('Container ID',
                                _containerIDController, _isEditing),
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
                                  Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: ElevatedButton(
                                      style: buttonPrimary,
                                      onPressed: _isUpdatingExpense
                                          ? null
                                          : _updateExpense,
                                      child: const Text(
                                        'Mettre a jour',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
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

  Widget _buildTextFieldWithBorder(
      String label, TextEditingController controller, bool enabled) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      //color: Colors.indigo.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
          Container(
            height: 46,
            decoration: BoxDecoration(
              color: _isEditing ? Colors.white : Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: _isEditing
                  ? null // Si _isEditing est vrai, n'incluez aucune décoration
                  : const InputDecoration(
                      border: InputBorder.none,
                    ),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              enabled: enabled,
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
    widget.onUpdate(
      widget.expense.id,
      _nameController.text,
      _slugController.text,
      int.parse(_totalController.text),
      int.parse(_paidController.text),
      int.parse(_containerIDController.text),
      int.parse(_createdByController.text),
      _createdAtController.text,
      int.parse(_updatedByController.text),
      _updatedAtController.text,
    );
    Fluttertoast.showToast(
      msg: 'Updated Successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
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
