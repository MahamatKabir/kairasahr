import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kairasahrl/screens/depenses/depenseadd_screen.dart';
import 'package:kairasahrl/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DepenseAddScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SignInPage(),
      //   '/signup': (context) => SignUpPage(),
      // },
    );
  }
}
