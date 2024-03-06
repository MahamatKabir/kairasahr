import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool
      isRequired; // Nouvelle propriété pour contrôler l'affichage de l'étoile
  final TextInputType keyboardType;
  final bool? isFieldEmpty;
  final bool isArticleField;
  final bool isContainerNameField;
  final bool isCustomerField;
  final bool isCustomerTelField;
  final bool isStatusField;
  final bool isAmountField;
  final bool isCityField;
  final bool isContSizeField;
  final bool obscureText;
  final int maxLines;
  final bool? isButtonClick; // Nouveau paramètre
  final ValueChanged<String>? onChanged;
  final VoidCallback? onButtonPressed;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.isRequired =
        false, // Défaut à false, l'étoile ne sera pas affichée par défaut
    this.keyboardType = TextInputType.text,
    this.isFieldEmpty,
    this.isArticleField = false,
    this.isContainerNameField = false,
    this.isCustomerField = false,
    this.isCustomerTelField = false,
    this.isStatusField = false,
    this.isAmountField = false,
    this.isCityField = false,
    this.isContSizeField = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onButtonPressed,
    this.isButtonClick,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFieldEmpty = false; // Ajout d'un nouvel état local
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.labelText, // Texte de l'étiquette
                style: TextStyle(fontSize: 13, color: Colors.indigo.shade900),
              ),
              if (widget.isRequired) // Vérifie si le champ est requis
                const TextSpan(
                  text:
                      ' *', // Ajoute une étoile pour indiquer que le champ est requis
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.red), // Couleur rouge pour l'étoile
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: widget.maxLines * 45.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: widget.isFieldEmpty ?? false
                    ? Colors.red.withOpacity(0.7)
                    : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: '',
              border: InputBorder.none,
              errorText: (widget.isButtonClick ?? false && _isFieldEmpty)
                  ? 'Ce champ est obligatoire'
                  : null,
            ),
            onChanged: (value) {
              if (widget.isButtonClick ?? false) {
                // Vérifie si le bouton est cliqué
                setState(() {
                  _isFieldEmpty = value.isEmpty; // Mettre à jour _isFieldEmpty
                });
              }
              widget.onChanged?.call(value);
            },
          ),
        ),
      ],
    );
  }
}
