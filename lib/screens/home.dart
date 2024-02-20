import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:kairasahrl/screens/add_screen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/city/citylist_screen.dart';
import 'package:kairasahrl/screens/container/containerlist_screen.dart';

import 'package:intl/intl.dart';
import 'package:kairasahrl/screens/depenses/depenselist_screen.dart';
import 'package:kairasahrl/screens/profile/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation vers la page correspondante en fonction de l'index sélectionné
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());
  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade50,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Mahamat kabir',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
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
                    height: 150,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _cardMenu(
                          onTap: () {},
                          title: 'UTILISATEUR',
                          icon: 'assets/images/utilisateur.jpeg'),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 1),
          height: 54,
          width: 54,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddScreen()),
              );
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.indigo),
              borderRadius: BorderRadius.circular(150),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.indigo,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black12,
          selectedItemColor: Colors.indigo,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 1 ? IconlyBold.user2 : IconlyLight.user2),
              label: "User",
            ),
          ],
        ));
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
