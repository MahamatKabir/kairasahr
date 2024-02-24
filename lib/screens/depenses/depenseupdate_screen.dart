import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/depense_model.dart';
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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            CustomBackgroundContainer(
              title: 'Depense Detail',
              leadingIcon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _isEditing
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isEditing = false;
                                });
                              },
                              child: const HeroIcon(HeroIcons.check,
                                  size: 20, color: Colors.white),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                              child: const HeroIcon(HeroIcons.queueList,
                                  size: 20, color: Colors.white),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Container(
                    color: Colors.indigo.shade50,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextFieldWithBorder(
                            'Article:',
                            _nameController,
                            _isEditing,
                          ),
                          _buildTextFieldWithBorder(
                              'Total:', _totalController, _isEditing),
                          _buildTextFieldWithBorder(
                              'Paid:', _paidController, _isEditing),
                          _buildTextFieldWithBorder('Container ID:',
                              _containerIDController, _isEditing),
                          _buildTextFieldWithBorder(
                              'Created By:', _createdByController, false),
                          _buildTextFieldWithBorder(
                              'Created At:', _createdAtController, false),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _isEditing,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: _isUpdatingExpense
                                      ? null
                                      : _updateExpense,
                                  child: const Text('Update'),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onDelete(widget.expense.id);
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: 'Depense Deleted Successfully',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                    );
                                  },
                                  child: const Text('Delete'),
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
      width: 350,
      color: Colors.indigo.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 1, 0, 66),
            ),
            width: 110,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: TextField(
              controller: controller,
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
