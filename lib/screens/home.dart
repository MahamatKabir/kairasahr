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
      backgroundColor: Colors.indigo.shade100,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mahamat kabir',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
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
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
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
                  height: 190,
                  scale: 1,
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
                const Text(
                  'SERVICES',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
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
                        title: 'CONTAINERS',
                        icon: 'assets/images/conta.jpeg'),
                    const SizedBox(
                      width: 15,
                    ),
                    _cardMenu(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DepenseListScreen()),
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
                        title: 'UTILISATEUR',
                        icon: 'assets/images/utilisateur.jpeg'),
                    const SizedBox(
                      width: 15,
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
            ))
          ],
        ),
      )),
    );
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
          margin: const EdgeInsets.only(right: 1),
          width: 140,
          decoration: BoxDecoration(
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
