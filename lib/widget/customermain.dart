import 'package:flutter/material.dart';
import 'package:kairasahrl/widget/button.dart';

class CustomMainContainer extends StatelessWidget {
  final Widget nameTextField;

  final bool isAdding;
  final VoidCallback onAddPressed;

  const CustomMainContainer({
    Key? key,
    required this.nameTextField,
    required this.isAdding,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 430,
      width: 340,
      child: Positioned(
        //bottom: 80,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: const Color(0xffC5C5C5),
                ),
              ),
              child: nameTextField,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: buttonPrimary,
              onPressed: isAdding ? null : onAddPressed,
              child: isAdding
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Ajouter',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
