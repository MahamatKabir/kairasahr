import 'package:flutter/material.dart';
import 'package:kairasahrl/screens/city/citylist_screen.dart';
import 'package:kairasahrl/screens/container/containerlist_screen.dart';

import 'package:intl/intl.dart';
import 'package:kairasahrl/screens/depenses/depenselist_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        toolbarHeight: 10, // Spécifiez ici la hauteur personnalisée
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 700, child: uppart()),
            ),
          ],
        ),
      ),
    );
  }

  uppart() {
    return Stack(children: [
      Container(
        color: Colors.indigo,
        height: 400,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 3,
                              color: Colors.grey,
                            ),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/cont.png"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenu',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Mahamat kabir',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        dayOfWeek,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/airplane.png',
                  width: 500,
                  height: 205,
                  scale: 2,
                )),
                const SizedBox(
                  height: 1,
                ),
                const Center(
                  child: Text(
                    'Société Kaïra Sarl',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ))
          ],
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height *
            0.30, // 10% de la hauteur de l'écran à partir du haut
        left: MediaQuery.of(context).size.width *
            0.17, // 5.6% de la largeur de l'écran à partir de la gauche
        child: Container(
          child: Column(
            children: [
              const Text(
                'SERVICES',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      title: 'CONTENEURS',
                      icon: 'assets/images/conta.jpeg'),
                  const SizedBox(
                    width: 20,
                  ),
                  _cardMenu(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DepenseListScreen()),
                        );
                      },
                      title: 'DEPENSES',
                      icon: 'assets/images/expense.png'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cardMenu(
                      onTap: () {},
                      title: 'UTILISATEURS',
                      icon: 'assets/images/utilisateur.jpeg'),
                  const SizedBox(
                    width: 20,
                  ),
                  _cardMenu(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityListScreen()),
                        );
                      },
                      title: 'VILLES',
                      icon: 'assets/images/ville.jpeg'),
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }

  _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.indigo,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.only(right: 1),
          width: 140,
          height: 165,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Column(children: [
            Image.asset(
              icon,
              width: 80,
              height: 80,
            ),
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
