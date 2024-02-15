import 'package:flutter/material.dart';
import 'package:kairasahrl/screens/container/containerlist_screen.dart';
import 'package:kairasahrl/screens/user_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade50,
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Salut Fadoul',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      size: 28,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                      child: Image.asset(
                    'assets/images/container.png',
                    scale: 1,
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Text(
                      'KAİRA-SAHRL',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Text(
                    'SERVICES',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ContainerListScreen()),
                            );
                          },
                          title: 'CONTAINERS',
                          icon: 'assets/images/conta.jpeg'),
                      _cardMenu(
                          title: 'DEPENSES', icon: 'assets/images/expense.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserScreen()),
                            );
                          },
                          title: 'UTILISATEUR',
                          icon: 'assets/images/utilisateur.jpeg'),
                      _cardMenu(
                          title: 'VILLES', icon: 'assets/images/ville.jpeg'),
                    ],
                  )
                ],
              ))
            ],
          ),
        )));
  }

  _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.only(right: 5),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: color,
          ),
          child: Column(children: [
            Image.asset(icon),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ]),
        ),
      ),
    );
  }
}
