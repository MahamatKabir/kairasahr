import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/city_model.dart';
import 'package:kairasahrl/widget/button.dart';
import 'package:kairasahrl/widget/customer.dart';

class CityDetailScreenn extends StatefulWidget {
  final City city;

  final Function(int) onDelete; // Fonction de suppression par ID
  final Function(int, String, String, String) onUpdate;

  const CityDetailScreenn({
    Key? key,
    required this.city,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _CityDetailScreennState createState() => _CityDetailScreennState();
}

class _CityDetailScreennState extends State<CityDetailScreenn> {
  late TextEditingController _nameController;
  late TextEditingController _slugController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.city.name);
    _slugController = TextEditingController(text: widget.city.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CustomBackgroundContainer(
              title: 'Ville detail',
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
                  padding: const EdgeInsets.only(top: 70),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.shade50,
                    ),
                    width: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTextFieldWithBorder(
                              'Nom de la Ville', _nameController),
                          // _buildTextFieldWithBorder('Slug:', _slugController),
                          if (!_isEditing)
                            _buildTextWithBorder(
                                'Date de création: ${widget.city.createdAt}'),
                          // _buildTextWithBorder('ID: ${widget.city.id}'),

                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _isEditing,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: buttonPrimary,
                                  onPressed: () {
                                    // Action pour mettre à jour la ville
                                    widget.onUpdate(
                                      widget.city.id,
                                      _nameController.text,
                                      _slugController.text,
                                      widget.city.createdAt,
                                    );
                                    Fluttertoast.showToast(
                                      msg: ' Mise à jour avec succès',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                    );
                                  },
                                  child: const Text(
                                    'Mettre à jour',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: buttonDelete,
                                  onPressed: () {
                                    // Appeler la fonction onDelete pour supprimer la ville
                                    // widget.onDelete();
                                    // Appeler la fonction onCityDeleteById pour supprimer la ville par ID
                                    widget.onDelete(widget.city
                                        .id); // Appeler la fonction de suppression avec l'ID de la ville
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: 'Ville supprimée avec succès',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                    );
                                  },
                                  child: const Text('Supprimer',
                                      style: TextStyle(color: Colors.white)),
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
      String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      width: 400,
      color: Colors.indigo.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
          Container(
            height: 50,
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
              enabled: _isEditing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithBorder(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      width: 400,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    super.dispose();
  }
}
