import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kairasahrl/models/city_model.dart';
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.city.name);
    _slugController = TextEditingController(text: widget.city.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CustomBackgroundContainer(
              title: 'Detail City',
              leadingIcon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 450,
                width: 340,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextFieldWithBorder(
                          'Nom de la Ville:', _nameController),
                      _buildTextFieldWithBorder('Slug:', _slugController),
                      _buildTextWithBorder(
                          'Date de création: ${widget.city.createdAt}'),
                      _buildTextWithBorder('ID: ${widget.city.id}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
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
                            child: const Text('Mettre à jour'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
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
                            child: const Text('Supprimer'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithBorder(
      String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: 300,
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
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
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

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    super.dispose();
  }
}
