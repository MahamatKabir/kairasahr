import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/city/citydetail_screen.dart';
import 'package:kairasahrl/screens/profile/profile_screen.dart';

import '../../models/city_model.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  final List<City> _cities = [
    City(
        name: 'Ndjamena ville', slug: 'city_1', createdAt: '2024-02-06', id: 1),
    City(name: 'Sahr', slug: 'city_2', createdAt: '2024-02-07', id: 2),
    City(name: 'Mondou', slug: 'city_1', createdAt: '2024-02-06', id: 1),
    City(name: 'Koumra', slug: 'city_2', createdAt: '2024-02-07', id: 2),
    City(name: 'Doba', slug: 'city_1', createdAt: '2024-02-06', id: 1),
    City(name: 'Bongore', slug: 'city_2', createdAt: '2024-02-07', id: 2),
    City(name: 'Léré', slug: 'city_1', createdAt: '2024-02-06', id: 1),
    City(name: 'Amdjarass', slug: 'city_2', createdAt: '2024-02-07', id: 2),

    // Ajoutez d'autres villes fictives si nécessaire
  ];

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void deleteCity(int id) {
    // Code pour supprimer la ville avec l'ID spécifié
    setState(() {
      // Mettez à jour la liste des villes après la suppression
      _cities.removeWhere((city) => city.id == id);
    });
  }

  void updateCity(int id, String newName, String newSlug, String newCreatedAt) {
    setState(() {
      // Recherchez la ville avec l'ID spécifié dans la liste
      for (int i = 0; i < _cities.length; i++) {
        if (_cities[i].id == id) {
          // Mettez à jour les détails de la ville
          _cities[i] = City(
            id: id,
            name: newName,
            slug: newSlug,
            createdAt: newCreatedAt,
          );
          break; // Arrêtez la boucle une fois la mise à jour effectuée
        }
      }
    });
  }

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
          MaterialPageRoute(builder: (context) => const BottomBarScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade50,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 0, 66),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
            child: Text(
              'Liste des Villes',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (valuee) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.indigo, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.indigo, width: 1),
                  ),
                  hintText: "Vous recherchez ? ",
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: MediaQuery.removePadding(
            context: context,
            removeTop: true, // Supprimer le padding du haut
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: _cities.length,
              itemBuilder: (context, index) {
                final city = _cities[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityDetailScreenn(
                          city: city,
                          onDelete:
                              deleteCity, // Passer la fonction de suppression
                          onUpdate: updateCity,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              city.name,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const HeroIcon(
                              HeroIcons.chevronRight,
                              size: 16,
                              color: Colors.indigo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
        ]),
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
                MaterialPageRoute(builder: (context) => const AddScreenne()),
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

  // _buttonContainer() {
  //   return Positioned(
  //     right: 40,
  //     bottom: 0,
  //     child: GestureDetector(
  //         onTap: () {
  //       },
  //         child: Container(
  //           height: 60,
  //           width: 60,
  //           decoration: BoxDecoration(
  //               image: const DecorationImage(
  //                   image: AssetImage("images/lines.png")),
  //               boxShadow: [
  //                 BoxShadow(
  //                     blurRadius: 15,
  //                     offset: const Offset(0, 1),
  //                     color: const Color(0xFF11324d).withOpacity(0.2))
  //               ]),
  //         )),
  //   );
  // }
}
