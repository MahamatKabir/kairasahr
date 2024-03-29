import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon; // Utilisez IconData pour l'icône
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                // Utilisez simplement Icon avec l'icône IconData
                icon, // Utilisez l'icône IconData
                color: Colors.indigo.shade500,
                size: 22,
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(text)),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
