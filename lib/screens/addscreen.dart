import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/screens/city/cityAdd_screen.dart';
import 'package:kairasahrl/screens/container/containeradd_screen.dart';
import 'package:kairasahrl/screens/depenses/depenseadd_screen.dart';

class AddScreenne extends StatefulWidget {
  const AddScreenne({super.key});

  @override
  State<AddScreenne> createState() => _AddScreenneState();
}

class _AddScreenneState extends State<AddScreenne> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 2, 95),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(''),
        ),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10),
            child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.shade100,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                tabs: [
                  Container(
                    width: 80,
                    child: const Tab(
                      icon: HeroIcon(
                        HeroIcons.viewColumns,
                        color: Color.fromARGB(255, 4, 2, 95),
                      ),
                      text: 'Container',
                    ),
                  ),
                  Container(
                    width: 80,
                    child: const Tab(
                      icon: HeroIcon(
                        HeroIcons.currencyDollar,
                        color: Color.fromARGB(255, 4, 2, 95),
                      ),
                      text: 'Depense',
                    ),
                  ),
                  Container(
                    width: 80,
                    child: const Tab(
                      icon: HeroIcon(
                        HeroIcons.buildingOffice2,
                        color: Color.fromARGB(255, 4, 2, 95),
                      ),
                      text: 'Ville',
                    ),
                  ),
                ]),
          ),
          const Expanded(
            child: TabBarView(children: [
              ContainerAddScreen(),
              DepenseAddScreen(),
              CityAddScreen(),
            ]),
          )
        ]),
      ),
    );
  }
}
