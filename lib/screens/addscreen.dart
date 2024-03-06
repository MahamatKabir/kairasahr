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
                  color: Colors.indigo.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10),
            child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 4, 2, 95),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                tabs: [
                  Container(
                    width: 80,
                    child: Tab(
                      icon: HeroIcon(
                        HeroIcons.viewColumns,
                        color: Colors.indigo.shade100,
                      ),
                      text: 'Conteneur',
                    ),
                  ),
                  Container(
                    width: 80,
                    child: Tab(
                      icon: HeroIcon(
                        HeroIcons.currencyDollar,
                        color: Colors.indigo.shade100,
                      ),
                      text: 'Depense',
                    ),
                  ),
                  Container(
                    width: 80,
                    child: Tab(
                      icon: HeroIcon(
                        HeroIcons.buildingOffice2,
                        color: Colors.indigo.shade100,
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
