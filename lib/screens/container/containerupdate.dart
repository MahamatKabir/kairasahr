import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/widget/button.dart';
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
              color: Colors.indigo.shade50,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildEditableField(
                      label: 'Container Name:',
                      controller: _nameController,
                    ),
                    _buildEditableField(
                      label: 'Customer:',
                      controller: _customerController,
                    ),
                    _buildEditableField(
                      label: 'Customer Tel:',
                      controller: _customerTelController,
                    ),
                    _buildEditableField(
                      label: 'Slug:',
                      controller: _slugController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 4,
                          child: _buildEditableField(
                            label: 'Ville ID:',
                            controller: _cityIDController,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: _buildEditableField(
                            label: 'Statut:',
                            controller: _statusController,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: _buildEditableField(
                            label: 'Type de Conteneur',
                            controller: _contTypeIDController,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: _buildReadOnlyField(
                              label: 'ID:',
                              text: '${widget.container.id}',
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: _buildReadOnlyField(
                              label: 'Created At:',
                              text: widget.container.createdAt,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _isEditing ? _updateContainer : null,
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 2),
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

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      color: Colors.indigo.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.edit),
          //       onPressed: () {
          //         setState(() {
          //           _isEditing = true;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: TextField(
              controller: controller,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Colors.indigo.shade50,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
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
