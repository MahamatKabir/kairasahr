import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/widget/customer.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

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
  final List<Expense> _depenses = [
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 2,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 90000,
      paid: 150,
      containerID: 3,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 700000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 3000000,
      paid: 150,
      containerID: 4,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),

    // Add more Container objects if needed
  ];

  final double _width = 600; // Largeur initiale du conteneur
  double _height = 110; // Hauteur initiale du conteneur
  bool _isExpanded = false; // État de l'expansion du conteneur

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _height = 150; // Hauteur augmentée
      } else {
        _height = 110; // Hauteur réduite
      }
    });
  }

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
              title: 'Container Detail',
              leadingIcon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Container(
              height: 600,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 10.0),
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
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              _height += details.delta.dy;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _width,
                            height: _height,
                            color: Colors.indigo.shade50,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    label: 'Broker:',
                                    controller: _brokerController,
                                  ),
                                  _buildEditableField(
                                    label: 'Broker Tel:',
                                    controller: _brokerTelController,
                                  ),
                                  _buildEditableField(
                                    label: 'Amount:',
                                    controller: _amountController,
                                  ),
                                  _buildEditableField(
                                    label: 'NewC:',
                                    controller: _newCController,
                                  ),
                                  _buildEditableField(
                                    label: 'Container Details:',
                                    controller: _contDetailsController,
                                  ),
                                  _buildEditableField(
                                    label: 'Ville ID:',
                                    controller: _cityIDController,
                                  ),
                                  _buildEditableField(
                                    label: 'Statut:',
                                    controller: _statusController,
                                  ),
                                  _buildEditableField(
                                    label: 'TypeC',
                                    controller: _contTypeIDController,
                                  ),
                                  _buildReadOnlyField(
                                    label: 'Created At:',
                                    text: widget.container.createdAt,
                                  ),
                                  const SizedBox(height: 5),
                                  Visibility(
                                    visible: _isEditing,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: _isEditing
                                              ? _updateContainer
                                              : null,
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
                                            widget
                                                .onDelete(widget.container.id);
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                              msg:
                                                  'Container Deleted Successfully',
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
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: Colors.indigo.shade50,
                          width: 400,
                          height: 30,
                          child: IconButton(
                            color: const Color.fromARGB(255, 1, 1, 55),
                            icon: _isExpanded
                                ? const HeroIcon(HeroIcons.xMark)
                                : const HeroIcon(HeroIcons.listBullet),
                            onPressed: _toggleSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.indigo.shade50,
                    margin: const EdgeInsets.only(right: 80),
                    child: const Text(
                      'Dépenses associées au container',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _depenses != null
                                ? _depenses
                                    .where((depense) =>
                                        depense.containerID ==
                                        widget.container.id)
                                    .length
                                : 0,
                            itemBuilder: (context, index) {
                              if (_depenses != null) {
                                List<Expense> depensesForContainer = _depenses
                                    .where((depense) =>
                                        depense.containerID ==
                                        widget.container.id)
                                    .toList();
                                Expense depense = depensesForContainer[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to container details screen
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade50,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(5, 5),
                                              spreadRadius: 5.0,
                                              blurRadius: 10.0,
                                            )
                                          ],
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 200,
                                                            child: Text(
                                                              depense.article,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          SizedText(
                                                              text:
                                                                  'creer le ${depense.createdAt}',
                                                              color:
                                                                  Colors.green)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 70,
                                                        height: 27,
                                                        child: Center(
                                                          child: Container(
                                                            width: 200,
                                                            child: Text(
                                                              "${depense.total.toString()}FCFA",
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons
                                            .hourglass_empty, // Icone pour une liste vide
                                        size: 48,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      Text(
                                        "Aucune dépense associée",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ); // ou tout autre widget vide si la liste de dépenses est null
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(top: 12),
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo.shade50,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Flexible(
                flex: 7,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo.shade50,
                  ),
                  child: TextField(
                    controller: controller,
                    enabled: _isEditing,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
              ),
            ],
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
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(top: 12),
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo.shade50,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Flexible(
                flex: 7,
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo.shade50,
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              ),
            ],
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
    _newCController.text = widget.container.newC!;
    _contDetailsController.text = widget.container.contDetails!;
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
}
