import 'package:flutter/material.dart';
import 'package:kairasahrl/models/city_model.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/utils/color.dart';

class EditPage extends StatefulWidget {
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
  final bool isEditing;
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
  ) updateContainer; // Ajout du paramètre updateContainer
  final int? initialStatusValue; // Ajout de la variable initialStatusValue
  final int? initialContainerTypeValue;
  // Ajout de la variable initialContainerTypeValue
  const EditPage({
    Key? key,
    required this.container,
    required this.onDelete,
    required this.onUpdate,
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
  int? _containerTypeValue;
  int? _statusValue;
  final List<City> selectedCities = [
    City(id: 1, name: 'New York', slug: '', createdAt: ''),
    City(id: 2, name: 'Paris', slug: '', createdAt: ''),
    City(id: 3, name: 'Tokyo', slug: '', createdAt: ''),
    // Ajoutez d'autres villes si nécessaire
  ];
  City? _selectedCity;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _isEditing = widget.isEditing;
    // Initialiser les valeurs de Status et Container Type
    _statusValue = widget.initialStatusValue ??
        0; // Utilisation de la valeur initiale ou 0 par défaut
    _containerTypeValue = widget.initialContainerTypeValue ??
        0; // Utilisation de la valeur initiale ou 0 par défaut
// Utilisez la liste de villes sélectionnées
  }

  // Future<void> _loadCities() async {
  //   try {
  //     final cities = await fetchCities();
  //     setState(() {
  //       _cities = cities;
  //       _selectedCity = _cities.isNotEmpty ? _cities[0] : null;
  //     });
  //   } catch (e) {
  //     print('Failed to load cities: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            _isEditing ? 'Modifier' : 'Detail du Conteneur',
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
            // _buildEditableField(label: 'Slug', controller: _slugController),
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
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Ajustez selon vos besoins
              children: [
                Expanded(
                  flex: 5, // Ajustez selon vos besoins
                  child: _buildEditableField(
                    label: 'Mountant',
                    controller: _amountController,
                  ),
                ),
                const SizedBox(
                    width: 10), // Ajoutez un espacement entre les champs
                Expanded(
                  flex: 5, // Ajustez selon vos besoins
                  child: _buildDropdownButton(
                    label: 'Ville',
                    value: _selectedCity,
                    onChanged: _onCityChanged(),
                    items: _buildDropdownItems('City'),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildDropdownButton(
                    label: 'Status',
                    value: _statusValue ?? 0,
                    onChanged: _updateStatus,
                    items: [],
                  ),
                ),
                const SizedBox(
                    width: 1), // Ajouter un espacement entre les dropdowns
                Expanded(
                  flex: 6,
                  child: Container(
                    child: _buildDropdownButton(
                      label: 'Type de Conteneur',
                      value: _containerTypeValue,
                      onChanged: _updateContainerType,
                      items: [],
                    ),
                  ),
                ),
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
                      primary: Colors.indigo,
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
                      primary: Colors.red,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
        const SizedBox(height: 30.0),
      ],
    );
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
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
          child: DropdownButton<dynamic>(
            // Modifier le type en dynamique
            value: value,
            onChanged: onChanged,
            items: _buildDropdownItems(
                label), // Extraire la création d'éléments dans une méthode séparée
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }

  List<DropdownMenuItem<dynamic>> _buildDropdownItems(String label) {
    if (label == 'Status') {
      return [
        const DropdownMenuItem(
          value: 0,
          child: Text("Passif       "),
        ),
        const DropdownMenuItem(
          value: 1,
          child: Text("Actif"),
        ),
      ];
    } else if (label == 'Ville') {
      return selectedCities.map((city) {
        return DropdownMenuItem<int>(
          value: city.id,
          child: Text(city.name),
        );
      }).toList();
    } else if (label == 'Type de Conteneur') {
      return [
        // const DropdownMenuItem(
        //   value: 0,
        //   child: Text("20 pieds   "),
        // ),
        // const DropdownMenuItem(
        //   value: 1,
        //   child: Text("40 pieds   "),
        // ),
      ];
    }
    return [];
  }

  void _updateStatus(dynamic newValue) {
    // Mettre le type comme dynamique
    setState(() {
      _statusValue = newValue as int?; // Convertir newValue en int
    });
  }

  void _updateCity(City? city) {
    setState(() {
      _selectedCity = city;
    });
  }

  dynamic Function(dynamic) _onCityChanged() {
    return (dynamic newValue) {
      if (newValue is City) {
        _updateCity(newValue);
      }
    };
  }

  void _updateContainerType(dynamic newValue) {
    setState(() {
      _containerTypeValue = newValue as int?; // Convertir newValue en int
    });
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

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  void _updateContainer() {
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

    // Mettre à jour le conteneur s'il n'y a pas d'erreurs
    widget.updateContainer(
      widget.container.id,
      _nameController.text,
      _slugController.text,
      _customerController.text,
      int.parse(_customerTelController.text),
      _brokerController.text,
      int.parse(_brokerTelController.text),
      double.parse(_amountController.text),
      _selectedCity!.id, // Utiliser l'ID de la ville sélectionnée
      _containerTypeValue!,
      _statusValue!,
      _newCController.text,
      _contDetailsController.text,
      widget.container.createdAt,
    );

    // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La mise à jour a été effectuée avec succès.'),
        backgroundColor: Colors.green,
      ),
    );

    // Retourner à l'écran précédent
    Navigator.pop(context);
  }
}
