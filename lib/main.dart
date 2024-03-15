import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kairasahrl/auth/sign_in.dart';
import 'package:kairasahrl/auth/sign_up.dart';
import 'package:kairasahrl/screens/container/containeradd_screen.dart';
import 'package:kairasahrl/screens/depenses/depenseadd_screen.dart';
import 'package:kairasahrl/screens/splash_screen.dart';
import 'screens/container/containerlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SignInPage(),
      //   '/signup': (context) => SignUpPage(),
      // },
    );
  }
}
