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
      backgroundColor: Colors.indigo.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 0, 66),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            _isEditing ? 'Modifier' : 'ville detail',
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
          alignment: AlignmentDirectional.center,
          children: [
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildCityDetails(),
      ],
    );
  }

  Widget _buildCityDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.indigo.shade100,
        ),
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextFieldWithBorder('Nom de la Ville', _nameController),
              if (!_isEditing)
                _buildTextWithBorder(
                    'Date de création: ${widget.city.createdAt}'),
              const SizedBox(height: 20),
              Visibility(
                visible: _isEditing,
                child: _buildEditingButtons(),
              ),
            ],
          ),
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
      child: Column(
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter $label',
                hintStyle: TextStyle(color: Colors.indigo.shade400),
              ),
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

  Widget _buildEditingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: buttonPrimary,
          onPressed: () {
            _updateCity();
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
            _deleteCity();
          },
          child: const Text('Supprimer', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _updateCity() {
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
  }

  void _deleteCity() {
    widget.onDelete(widget.city.id);
    Navigator.pop(context);
    Fluttertoast.showToast(
      msg: 'Ville supprimée avec succès',
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
    super.dispose();
  }
}
