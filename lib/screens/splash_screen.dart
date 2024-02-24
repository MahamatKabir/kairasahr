import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kairasahrl/screens/btm_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Get.to(const BottomBarScreen());
    });
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 1, 54),
        body: Center(
          child: Text(
            'Société Kaira Sarl',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
