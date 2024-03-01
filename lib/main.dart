import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/container/containerlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const ContainerListScreen(),
        routes: {
          ContainerListScreen.routeName: (ctx) => const ContainerListScreen(),
        });
  }
}
