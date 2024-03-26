import 'package:flutter/material.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/container/containerlist_screen.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/color.dart';

class EditPage extends StatefulWidget {
  final Conteneure container;
  final Function(int) onDelete;
  final bool isEditing;
  final Function(
    int,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    double,
    String,
    int,
    //int,
    String,
    String,
    String,
  ) updateContainer; // Ajout du paramètre updateContainer
  final int? initialStatusValue; // Ajout de la variable initialStatusValue
  final int? initialContainerTypeValue;
  // Ajout de la variable initialContainerTypeValue
  const EditPage({
    Key? key,
    required this.container,
    required this.onDelete,
    required this.isEditing,
    required this.updateContainer,
    this.initialStatusValue,
    this.initialContainerTypeValue, // Ajout du paramètre updateContainer
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _plaqueController = TextEditingController();
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
  int _containerTypeValue = 1;
  int? _statusValue;
  List<Map<String, dynamic>> _cityData = [];
  int? _selectedCity;
  //TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _isEditing = widget.isEditing;
    _statusValue = widget.initialStatusValue ?? 0;
    _containerTypeValue = 1;
    // Chargez les villes depuis l'API
    _fetchCityData();
  }

  Future<void> _fetchCityData() async {
    try {
      final List<Map<String, dynamic>> cities =
          await ApiService.fetchCityData();
      setState(() {
        _cityData = cities;
        if (_cityData.isNotEmpty) {
          _selectedCity = _cityData[0]['id'];
        }
      });
    } catch (e) {
      print('Error: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to load city data')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !_isEditing ? Colors.indigo.shade100 : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            _isEditing ? 'Modifier          ' : 'Detail du Conteneur',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildEditableField(
                label: 'Nom du conteneur', controller: _nameController),
            _buildEditableField(label: 'Plaque', controller: _plaqueController),
            _buildEditableField(
                label: 'Client(e)', controller: _customerController),
            _buildEditableField(
                label: 'Téléphone du client',
                controller: _customerTelController),
            _buildEditableField(
                label: 'Courtièr(e)', controller: _brokerController),
            _buildEditableField(
                label: 'Téléphone du courtièr',
                controller: _brokerTelController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Ajustez selon vos besoins
              children: [
                Expanded(
                  flex: 5, // Ajustez selon vos besoins
                  child: _buildEditableField(
                    label: 'Mountant',
                    controller: _amountController,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                // Ajoutez un espacement entre les champs
                if (_isEditing != true)
                  Expanded(
                    flex: 5, // Ajustez selon vos besoins
                    child: _buildEditableField(
                      label: 'City',
                      controller: _cityIDController,
                    ),
                  ),
                if (_isEditing == true)
                  Expanded(
                    flex: 5, // Ajustez selon vos besoins
                    child: DropdownButtonFormField<int>(
                      value: _selectedCity,
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value;
                        });
                      },
                      items: _cityData.map((city) {
                        return DropdownMenuItem<int>(
                          value: city['id']
                              as int, // Utilisez l'ID de la ville comme valeur
                          child: Text(city['name'] as String),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Ville',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner une ville';
                        }
                        return null;
                      },
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEditing != true)
                  Expanded(
                    flex: 5, // Ajustez selon vos besoins
                    child: _buildEditableField(
                      label: 'Status',
                      controller: _statusController,
                    ),
                  ),
                if (_isEditing == true)
                  Expanded(
                      flex: 5,
                      child: // Valeur initiale du dropdown
                          DropdownButton<int>(
                        value: _statusValue,
                        onChanged: (newValue) {
                          setState(() {
                            _statusValue = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "Actif",
                              style: TextStyle(
                                color: Colors.indigo.shade400,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              "Passif",
                              style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      )),

                const SizedBox(
                  width: 9,
                ),
                // Ajouter un espacement entre les dropdowns
                if (_isEditing != true)
                  Expanded(
                    flex: 5, // Ajustez selon vos besoins
                    child: _buildEditableField(
                      label: 'Type de Conteneur',
                      controller: _contTypeIDController,
                    ),
                  ),
                if (_isEditing == true)
                  Expanded(
                      flex: 5,
                      child: // Valeur initiale du dropdown
                          DropdownButton<int>(
                        value: _containerTypeValue,
                        onChanged: (newValue) {
                          setState(() {
                            _containerTypeValue = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "20 Pieds",
                              style: TextStyle(
                                color: Colors.indigo.shade400,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "40 pieds",
                              style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ))
              ],
            ),
            _buildEditableField(
              label: 'Nouveau C',
              controller: _newCController,
              isMultiline: true, // Rend le champ multiligne
            ),
            _buildEditableField(
              label: 'Détails du conteneur',
              controller: _contDetailsController,
              isMultiline: true, // Rend le champ multiligne
            ),
            Visibility(
              visible: _isEditing,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _isEditing ? _updateContainer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Mettre à jour',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textFieldBackground),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isEditing
                        ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Supprimer le champ"),
                                  content: const Text(
                                      "Êtes-vous sûr de vouloir supprimer ce champ ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        widget.onDelete(widget.container.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Supprimer"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Supprimer',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textFieldBackground),
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

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool isMultiline = false,
  }) {
    // Vérifier si le label est "Status" ou "Type de Conteneur"
    if (label == 'Status' || label == 'Type de Conteneur') {
      // Condition pour déterminer le texte en fonction de la valeur du contrôleur
      String displayText = '';
      if (controller.text == '1' && label == 'Status') {
        displayText = 'Actif';
      } else if (controller.text == '2' && label == 'Status') {
        displayText = 'Passif';
      } else if (controller.text == '1' && label == 'Type de Conteneur') {
        displayText = '20 pieds';
      } else if (controller.text == '2' && label == 'Type de Conteneur') {
        displayText = '40 pieds';
      } else {
        displayText = controller
            .text; // Si la valeur n'est ni 1 ni 2, affiche la valeur du contrôleur
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          AnimatedContainer(
            width: MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).size.height / 9,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: _isEditing ? Colors.white : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: isMultiline
                ? TextField(
                    controller: controller,
                    enabled: _isEditing,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entrer $label',
                      hintStyle: TextStyle(color: Colors.indigo.shade400),
                    ),
                  )
                : Text(
                    displayText, // Affiche le texte déterminé en fonction de la valeur du contrôleur
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 14.0,
                    ),
                  ),
          ),
          const SizedBox(height: 20.0),
        ],
      );
    } else {
      // Si le label n'est ni "Status" ni "Type de Conteneur", afficher le champ de texte sans modification
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: _isEditing ? Colors.white : Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: isMultiline
                ? TextField(
                    controller: controller,
                    enabled: _isEditing,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entrer $label',
                      hintStyle: TextStyle(color: Colors.indigo.shade400),
                    ),
                  )
                : TextField(
                    controller: controller,
                    enabled: _isEditing,
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entrer $label',
                      hintStyle: TextStyle(color: Colors.indigo.shade400),
                    ),
                  ),
          ),
          const SizedBox(height: 20.0),
        ],
      );
    }
  }

  Widget _buildDropdownButton({
    required String label,
    required dynamic value, // Mettre le type comme dynamique
    required Function(dynamic) onChanged, // Mettre le type comme dynamique
    required List<DropdownMenuItem<dynamic>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        AnimatedContainer(
          width: MediaQuery.of(context).size.width / 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: _isEditing ? Colors.white : Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          // child: DropdownButton<dynamic>(
          //   // Modifier le type en dynamique
          //   value: value,
          //   onChanged: onChanged,
          //   // items: _buildDropdownItems(
          //   //     label), // Extraire la création d'éléments dans une méthode séparée
          // ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }

  // List<DropdownMenuItem<dynamic>> _buildDropdownItems(String label) {
  //   if (_isEditing) {
  //     // Vérifiez si l'édition est activée
  //     if (label == 'Status') {
  //       return [
  // DropdownMenuItem(
  //   value: 0,
  //   child: Text(
  //     "Passif              ",
  //     style: TextStyle(
  //       color: Colors.indigo.shade400,
  //       fontSize: 14.0,
  //     ),
  //   ),
  // ),
  // DropdownMenuItem(
  //   value: 1,
  //   child: Text(
  //     "Actif             ",
  //     style: TextStyle(
  //       color: Colors.indigo.shade900,
  //       fontSize: 14.0,
  //     ),
  //   ),
  // ),
  //       ];
  //     } else if (label == 'Type de Conteneur') {
  //       return [
  //         DropdownMenuItem(
  //           value: 1,
  //           child: Text(
  //             "20 pieds",
  //             style: TextStyle(
  //               color: Colors.indigo.shade900,
  //               fontSize: 14.0,
  //             ),
  //           ),
  //         ),
  //         DropdownMenuItem(
  //           value: 2,
  //           child: Text(
  //             "40 pieds",
  //             style: TextStyle(
  //               color: Colors.indigo.shade900,
  //               fontSize: 14.0,
  //             ),
  //           ),
  //         ),
  //       ];
  //     }
  //   }
  //   return [];
  // }

  void _updateStatus(dynamic newValue) {
    // Mettre le type comme dynamique
    setState(() {
      _statusValue = newValue as int?; // Convertir newValue en int
    });
  }

  void _updateCity(int? selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
      if (selectedCity != null) {
        // Mettre à jour la valeur par défaut du dropdown
        _cityIDController.text = selectedCity.toString();
      }
    });
  }

  void _onCityChanged(int? selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
    });
  }

  // void _updateContainerType(dynamic newValue) {
  //   setState(() {
  //     _containerTypeValue = newValue; // Convertir newValue en int
  //   });
  // }

  void _initializeControllers() {
    _nameController.text = widget.container.name;
    _plaqueController.text = widget.container.plaque;
    _customerController.text = widget.container.customer;
    _customerTelController.text = widget.container.customerPhone.toString();
    _brokerController.text = widget.container.broker ?? '';
    _brokerTelController.text = widget.container.brokerPhone?.toString() ?? '';
    _amountController.text = widget.container.containerPrice.toString();
    _newCController.text = widget.container.containerInformationC!;
    _contDetailsController.text = widget.container.containerOtherDetails!;
    _cityIDController.text = widget.container.containerCityID.toString();
    _contTypeIDController.text = widget.container.containerType.toString();
    _statusController.text = widget.container.status.toString();
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  void _updateContainer() async {
    // Vérifier si tous les champs obligatoires sont remplis
    if (_nameController.text.isEmpty ||
        _customerController.text.isEmpty ||
        _customerTelController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedCity == null || // Vérifier si une ville est sélectionnée
        _statusValue == null || // Vérifier si un statut est sélectionné
        _containerTypeValue == null) {
      // Vérifier si un type de conteneur est sélectionné
      // Afficher un message d'erreur si un champ obligatoire est vide
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs obligatoires.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Vérifier si les champs de montant, téléphone client et téléphone courtier contiennent des lettres
    if (!_isNumeric(_customerTelController.text) ||
        !_isNumeric(_brokerTelController.text) ||
        !_isNumeric(_amountController.text)) {
      // Afficher un message d'erreur si l'un des champs contient une lettre
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Le montant, le téléphone client et le téléphone du courtier ne doivent contenir que des chiffres.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Récupération des données du formulaire

    // Validation des données

    // Préparation de la requête API
    final Map<String, dynamic> body = {
      'id': widget.container.id,
      'container_name': _nameController.text,
      'container_plate_no': _plaqueController.text,
      'customer_name': _customerController.text,
      'customer_phone': _customerTelController.text,
      'broker_name': _brokerController.text,
      'broker_phone': _brokerTelController.text,
      'container_price':
          double.parse(_amountController.text).toStringAsFixed(2),
      'container_city_id':
          _selectedCity, // Use the actual ID retrieved from the city selection
      'container_type_id': _containerTypeValue,
      'status': _statusValue,
      'container_information_c': _newCController.text,
      'container_other_details': _contDetailsController.text,
      'createdAt': widget.container.createdAt,
    };

    // Envoi de la requête API
    final response = await ApiClient.updateContainer(widget.container.id, body);

// Handle API response
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContainerListScreen()),
      );
    } else {
      // Update failed
      // ...
    }
  }
}
