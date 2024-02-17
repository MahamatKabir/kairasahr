import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/widget/customer.dart';

class ContainerUpScreen extends StatefulWidget {
  static const routeName = "/ContainerUpScreen";
  final Containere container;
  final Function(int) onDelete;
  final Function(
    int,
    String,
    String,
    String,
    String,
    int,
    int,
    int,
    String,
  ) onUpdate;

  const ContainerUpScreen({
    Key? key,
    required this.container,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _ContainerUpScreenState createState() => _ContainerUpScreenState();
}

class _ContainerUpScreenState extends State<ContainerUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _customerTelController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _cityIDController = TextEditingController();
  final TextEditingController _contTypeIDController = TextEditingController();

  bool _isUpdatingContainer = false;

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
        child: Stack(children: [
          CustomBackgroundContainer(
            title: 'Container Detail',
            leadingIcon: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTextFieldWithBorder(
                      'Container Name:',
                      _nameController,
                    ),
                    _buildTextFieldWithBorder('Customer:', _customerController),
                    _buildTextFieldWithBorder(
                        'Customer Tel:', _customerTelController),
                    _buildTextFieldWithBorder('Slug:', _slugController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 4,
                          child: _buildTextFieldWithBorder(
                              'Ville ID:', _cityIDController),
                        ),
                        Flexible(
                            flex: 3,
                            child: _buildTextFieldWithBorder(
                                'Statut:', _statusController)),
                        Flexible(
                          flex: 3,
                          child: _buildTextFieldWithBorder(
                              'Type de conteneur ID:', _contTypeIDController),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: _buildTextWithBorder(
                              'ID: ${widget.container.id}'),
                        ),
                        Flexible(
                          flex: 7,
                          child: _buildTextWithBorder(
                              'Created At: ${widget.container.createdAt}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              _isUpdatingContainer ? null : _updateContainer,
                          child: const Text('Update'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            widget.onDelete(widget.container.id);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Container Deleted Successfully',
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
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildTextFieldWithBorder(
      String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color(0xffC5C5C5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            // decoration: const InputDecoration(
            //   border: InputBorder.none,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithBorder(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: 300,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color(0xffC5C5C5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  void _initializeControllers() {
    _nameController.text = widget.container.name;
    _slugController.text = widget.container.slug;
    _customerController.text = widget.container.customer;
    _customerTelController.text = widget.container.customerTel;
    _statusController.text = widget.container.status.toString();
    _cityIDController.text = widget.container.cityID.toString();
    _contTypeIDController.text = widget.container.contTypeID.toString();
  }

  void _updateContainer() {
    widget.onUpdate(
      widget.container.id,
      _nameController.text,
      _slugController.text,
      _customerController.text,
      _customerTelController.text,
      int.parse(_cityIDController.text),
      int.parse(_contTypeIDController.text),
      int.parse(_statusController.text),
      widget.container.createdAt,
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
    _customerController.dispose();
    _customerTelController.dispose();
    _statusController.dispose();
    _cityIDController.dispose();
    _contTypeIDController.dispose();
    super.dispose();
  }
}
