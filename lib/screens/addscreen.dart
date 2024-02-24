import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/screens/city/cityAdd_screen.dart';
import 'package:kairasahrl/screens/container/containeradd_screen.dart';
import 'package:kairasahrl/screens/depenses/depenseadd_screen.dart';

class AddScreenne extends StatelessWidget {
  const AddScreenne({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 2, 95),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(''),
        ),
        body: const Column(children: [
          TabBar(tabs: [
            Tab(
              icon: HeroIcon(
                HeroIcons.viewColumns,
                color: Color.fromARGB(255, 4, 2, 95),
              ),
            ),
            Tab(
              icon: HeroIcon(
                HeroIcons.chartBar,
                color: Color.fromARGB(255, 4, 2, 95),
              ),
            ),
            Tab(
              icon: HeroIcon(
                HeroIcons.buildingOffice2,
                color: Color.fromARGB(255, 4, 2, 95),
              ),
            ),
          ]),
          Expanded(
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
