import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _checkFirstSeen();
  }

  Future<void> _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      setState(() {
        _showSplash = false;
      });
    } else {
      await prefs.setBool('seen', true);
      await Future.delayed(
          const Duration(seconds: 2)); // Temps d'affichage du SplashScreen
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      if (_showSplash) {
        Get.off(_buildSplashScreen());
      } else {
        Get.off(const BottomBarScreen());
      }
    });
    return _buildSplashScreen();
  }

  Widget _buildSplashScreen() {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 1, 54),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Société',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kaira Sarl',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}
