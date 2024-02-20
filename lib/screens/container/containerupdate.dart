// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:kairasahrl/models/container_model.dart';
// import 'package:kairasahrl/widget/customer.dart';

// class ContainerUpScreen extends StatefulWidget {
//   static const routeName = "/ContainerUpScreen";
//   final Containere container;
//   final Function(int) onDelete;
//   final Function(
//     int,
//     String,
//     String,
//     String,
//     int,
//     String,
//     int,
//     double,
//     int,
//     int,
//     int,
//     String,
//     String,
//     String,
//   ) onUpdate;

//   const ContainerUpScreen({
//     Key? key,
//     required this.container,
//     required this.onDelete,
//     required this.onUpdate,
//   }) : super(key: key);

//   @override
//   _ContainerUpScreenState createState() => _ContainerUpScreenState();
// }

// class _ContainerUpScreenState extends State<ContainerUpScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _slugController = TextEditingController();
//   final TextEditingController _customerController = TextEditingController();
//   final TextEditingController _customerTelController = TextEditingController();
//   final TextEditingController _brokerController = TextEditingController();
//   final TextEditingController _brokerTelController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _newCController = TextEditingController();
//   final TextEditingController _contDetailsController = TextEditingController();
//   final TextEditingController _cityIDController = TextEditingController();
//   final TextEditingController _contTypeIDController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();

//   bool _isEditing = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: Stack(children: [
//           CustomBackgroundContainer(
//             title: 'Container Detail',
//             leadingIcon: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Icon(Icons.arrow_back, color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 100.0),
//             child: Container(
//               color: Colors.indigo.shade50,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildEditableField(
//                       label: 'Container Name:',
//                       controller: _nameController,
//                     ),
//                     _buildEditableField(
//                       label: 'Customer:',
//                       controller: _customerController,
//                     ),
//                     _buildEditableField(
//                       label: 'Customer Tel:',
//                       controller: _customerTelController,
//                     ),
//                     _buildEditableField(
//                       label: 'Broker:',
//                       controller: _brokerController,
//                     ),
//                     _buildEditableField(
//                       label: 'Broker Tel:',
//                       controller: _brokerTelController,
//                     ),
//                     _buildEditableField(
//                       label: 'Amount:',
//                       controller: _amountController,
//                     ),
//                     _buildEditableField(
//                       label: 'NewC:',
//                       controller: _newCController,
//                     ),
//                     _buildEditableField(
//                       label: 'Container Details:',
//                       controller: _contDetailsController,
//                     ),
//                     _buildEditableField(
//                       label: 'Slug:',
//                       controller: _slugController,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Flexible(
//                           flex: 4,
//                           child: _buildEditableField(
//                             label: 'Ville ID:',
//                             controller: _cityIDController,
//                           ),
//                         ),
//                         Flexible(
//                           flex: 3,
//                           child: _buildEditableField(
//                             label: 'Statut:',
//                             controller: _statusController,
//                           ),
//                         ),
//                         Flexible(
//                           flex: 3,
//                           child: _buildEditableField(
//                             label: 'Type de Conteneur',
//                             controller: _contTypeIDController,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       color: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 5),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             flex: 5,
//                             child: _buildReadOnlyField(
//                               label: 'ID:',
//                               text: '${widget.container.id}',
//                             ),
//                           ),
//                           Flexible(
//                             flex: 5,
//                             child: _buildReadOnlyField(
//                               label: 'Created At:',
//                               text: widget.container.createdAt,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: _isEditing ? _updateContainer : null,
//                           child: const Text(
//                             'Update',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         ElevatedButton(
//                           onPressed: () {
//                             widget.onDelete(widget.container.id);
//                             Navigator.pop(context);
//                             Fluttertoast.showToast(
//                               msg: 'Container Deleted Successfully',
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               backgroundColor: Colors.green,
//                               textColor: Colors.white,
//                             );
//                           },
//                           child: const Text('Delete'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   Widget _buildEditableField({
//     required String label,
//     required TextEditingController controller,
//   }) {
//     return Container(
//       color: Colors.indigo.shade50,
//       padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
//       width: 350,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontSize: 10, color: Colors.black),
//           ),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     IconButton(
//           //       icon: Icon(Icons.edit),
//           //       onPressed: () {
//           //         setState(() {
//           //           _isEditing = true;
//           //         });
//           //       },
//           //     ),
//           //   ],
//           // ),
//           Container(
//             height: 50,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10), color: Colors.white),
//             child: TextField(
//               controller: controller,
//               enabled: _isEditing,
//               style: const TextStyle(color: Colors.black, fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReadOnlyField({
//     required String label,
//     required String text,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
//       width: 300,
//       height: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           width: 2,
//           color: Colors.indigo.shade50,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10), color: Colors.white),
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 10, color: Colors.black),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10), color: Colors.white),
//             child: Text(
//               text,
//               style: const TextStyle(fontSize: 20, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _initializeControllers() {
//     _nameController.text = widget.container.name;
//     _slugController.text = widget.container.slug;
//     _customerController.text = widget.container.customer;
//     _customerTelController.text = widget.container.customerTel.toString();
//     _brokerController.text = widget.container.broker ?? '';
//     _brokerTelController.text = widget.container.brokerTel?.toString() ?? '';
//     _amountController.text = widget.container.amount?.toString() ?? '';
//     _newCController.text = widget.container.newC;
//     _contDetailsController.text = widget.container.contDetails;
//     _cityIDController.text = widget.container.cityID.toString();
//     _contTypeIDController.text = widget.container.contTypeID.toString();
//     _statusController.text = widget.container.status.toString();
//   }

//   void _updateContainer() {
//     widget.onUpdate(
//       widget.container.id,
//       _nameController.text,
//       _slugController.text,
//       _customerController.text,
//       int.parse(_customerTelController.text),
//       _brokerController.text,
//       int.parse(_brokerTelController.text),
//       double.parse(_amountController.text),
//       int.parse(_cityIDController.text),
//       int.parse(_contTypeIDController.text),
//       int.parse(_statusController.text),
//       _newCController.text,
//       _contDetailsController.text,
//       widget.container.createdAt,
//     );
//     Fluttertoast.showToast(
//       msg: 'Updated Successfully',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//     );
//   }
// }
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
    int,
    String,
    int,
    double,
    int,
    int,
    int,
    String,
    String,
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
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _brokerTelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCController = TextEditingController();
  final TextEditingController _contDetailsController = TextEditingController();
  final TextEditingController _cityIDController = TextEditingController();
  final TextEditingController _contTypeIDController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Container Name",
                            _nameController.text, _nameController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Customer:',
                      controller: _customerController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Customer",
                            _customerController.text, _customerController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Customer Tel:',
                      controller: _customerTelController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(
                            context,
                            "Customer Tel",
                            _customerTelController.text,
                            _customerTelController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Broker:',
                      controller: _brokerController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Broker",
                            _brokerController.text, _brokerController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Broker Tel:',
                      controller: _brokerTelController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Broker Tel",
                            _brokerTelController.text, _brokerTelController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Amount:',
                      controller: _amountController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Amount",
                            _amountController.text, _amountController);
                      },
                    ),
                    _buildEditableField(
                      label: 'NewC:',
                      controller: _newCController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "NewC", _newCController.text,
                            _newCController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Container Details:',
                      controller: _contDetailsController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(
                            context,
                            "Container Details",
                            _contDetailsController.text,
                            _contDetailsController);
                      },
                    ),
                    _buildEditableField(
                      label: 'Slug:',
                      controller: _slugController,
                      icon: Icons.edit,
                      onPressed: () {
                        _showEditDialog(context, "Slug", _slugController.text,
                            _slugController);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 4,
                          child: _buildEditableField(
                            label: 'Ville ID:',
                            controller: _cityIDController,
                            icon: Icons.edit,
                            onPressed: () {
                              _showEditDialog(context, "Ville ID",
                                  _cityIDController.text, _cityIDController);
                            },
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: _buildEditableField(
                            label: 'Statut:',
                            controller: _statusController,
                            icon: Icons.edit,
                            onPressed: () {
                              _showEditDialog(context, "Statut",
                                  _statusController.text, _statusController);
                            },
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: _buildEditableField(
                            label: 'Type de Conteneur',
                            controller: _contTypeIDController,
                            icon: Icons.edit,
                            onPressed: () {
                              _showEditDialog(
                                  context,
                                  "Type de Conteneur",
                                  _contTypeIDController.text,
                                  _contTypeIDController);
                            },
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
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      color: Colors.indigo.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
              IconButton(
                icon: Icon(icon),
                onPressed: onPressed,
              ),
            ],
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: TextField(
              controller: controller,
              enabled: false,
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
    _customerTelController.text = widget.container.customerTel.toString();
    _brokerController.text = widget.container.broker ?? '';
    _brokerTelController.text = widget.container.brokerTel?.toString() ?? '';
    _amountController.text = widget.container.amount?.toString() ?? '';
    _newCController.text = widget.container.newC;
    _contDetailsController.text = widget.container.contDetails;
    _cityIDController.text = widget.container.cityID.toString();
    _contTypeIDController.text = widget.container.contTypeID.toString();
    _statusController.text = widget.container.status.toString();
  }

  void _updateContainer() {
    widget.onUpdate(
      widget.container.id,
      _nameController.text,
      _slugController.text,
      _customerController.text,
      int.parse(_customerTelController.text),
      _brokerController.text,
      int.parse(_brokerTelController.text),
      double.parse(_amountController.text),
      int.parse(_cityIDController.text),
      int.parse(_contTypeIDController.text),
      int.parse(_statusController.text),
      _newCController.text,
      _contDetailsController.text,
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

  void _showEditDialog(BuildContext context, String title, String currentValue,
      TextEditingController controller) async {
    final TextEditingController _editController =
        TextEditingController(text: currentValue);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(controller: _editController),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  controller.text = _editController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
