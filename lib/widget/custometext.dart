import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? isFieldEmpty; // Déclarer comme nullable
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isFieldEmpty, // Rendre facultatif
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(fontSize: 13, color: Colors.indigo.shade900),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: widget.maxLines * 45.0,
          decoration: BoxDecoration(
            color: Colors.white, // Vérifier si isFieldEmpty est null
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: widget.isFieldEmpty ?? false
                    ? Colors.red
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
            decoration: const InputDecoration(
              labelText: '',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              widget.onChanged?.call(value); // Utiliser onChanged
            },
          ),
        ),
      ],
    );
  }
}
