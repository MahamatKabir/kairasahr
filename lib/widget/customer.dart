import 'package:flutter/material.dart';

class CustomBackgroundContainer extends StatelessWidget {
  final String title;
  final Widget leadingIcon;

  const CustomBackgroundContainer({
    Key? key,
    required this.title,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 3, 45),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(right: 300),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: leadingIcon,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
