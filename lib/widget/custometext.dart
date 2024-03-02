import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int
      maxLines; // Nouvelle propriété pour spécifier le nombre de lignes maximales

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1, // Par défaut, 1 ligne pour le champ de texte
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 13),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: maxLines *
              45.0, // Hauteur ajustée en fonction du nombre de lignes
          decoration: BoxDecoration(
            color: Colors.white,
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
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines, // Utilisez la valeur maxLines fournie
            decoration: const InputDecoration(
              labelText: '',
              border: InputBorder.none,
            ),
          ),
        ),
        // Espace supplémentaire après le champ de texte
      ],
    );
  }
}
