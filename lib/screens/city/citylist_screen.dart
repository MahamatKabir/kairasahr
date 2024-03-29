import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/city/citydetail_screen.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/screens/utils/color.dart';

import '../../models/city_model.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  final List<City> _cities = []; // Liste de villes
  final List<City> _filteredCities = []; // Liste filtrée de villes
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _fetchCities();
    }
  }

  Future<void> _fetchCities() async {
    try {
      // Appeler votre API pour récupérer les données des villes
      List<Map<String, dynamic>> cityData = await ApiService.fetchCityData();

      // Convertir les données de la ville en une liste de City
      List<City> cities = cityData.map((data) => City.fromJson(data)).toList();

      setState(() {
        // Mettre à jour la liste des villes filtrées avec les données reçues de l'API
        _cities.addAll(cities);
        _filteredCities.addAll(cities);
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      // Gérer les erreurs ici, par exemple afficher un message à l'utilisateur
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void _filterCities(String searchText) {
    _filteredCities.clear(); // Effacer la liste filtrée actuelle

    // Parcourir toutes les villes et ajouter celles qui correspondent au critère de recherche
    for (City city in _cities) {
      if (city.name.toLowerCase().startsWith(searchText.toLowerCase())) {
        _filteredCities.add(city);
      }
    }
    setState(
        () {}); // Mettre à jour l'interface utilisateur avec les villes filtrées
  }

  void deleteCity(int id) async {
    setState(() {
      _isLoading = true;
    });
    await ApiService.deleteCity(id);
    setState(() {
      _cities.removeWhere((city) => city.id == id);
      _isLoading = false;
    });
    _fetchCities();
  }

  void updateCity(int id, String newName) async {
    setState(() {
      _isLoading = true;
    });

    // Appel à la méthode pour mettre à jour la ville dans l'API
    await ApiService.updateCity(id, newName);

    // Mettre à jour la ville dans la liste locale
    setState(() {
      for (int i = 0; i < _cities.length; i++) {
        if (_cities[i].id == id) {
          _cities[i] = City(
            id: id,
            name: newName,
            slug: _cities[i].slug,
            createdAt: _cities[i].createdAt,
          );
          break;
        }
      }
      _isLoading = false;
    });

    // Afficher un message de succès
    Fluttertoast.showToast(
      msg: 'Mise à jour réussie',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
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
          MaterialPageRoute(
              builder: (context) => const BottomBarScreen(selectedIndex: 0)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomBarScreen(selectedIndex: 1)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade100,
        appBar: AppBar(
          backgroundColor: AppColors.appbar,
          iconTheme: const IconThemeData(color: AppColors.textFieldBackground),
          title: const Center(
            child: Text(
              'Liste des Villes       ',
              style:
                  TextStyle(color: AppColors.textFieldBackground, fontSize: 20),
            ),
          ),
        ),
        body: _isLoading
            ? Center(child: const CircularProgressIndicator())
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      //focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (value) {
                        _filterCities(
                            value); // Appeler la fonction de filtrage lors de la saisie de texte
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.appbar, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.appbar, width: 1),
                        ),
                        hintText: "Vous recherchez ? ",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            _searchTextController.clear();
                            _searchTextFocusNode.unfocus();
                            _filterCities('');
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
                  child: _filteredCities.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          itemCount: _filteredCities.length,
                          itemBuilder: (context, index) {
                            final city = _filteredCities[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CityDetailScreenn(
                                      city: city,
                                      onDelete:
                                          deleteCity, // Passer la fonction de suppression
                                      onUpdate:
                                          updateCity, // Passer la fonction de mise à jour
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: AppColors.textFieldBackground,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          city.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: AppColors.textColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const HeroIcon(
                                          HeroIcons.chevronRight,
                                          size: 16,
                                          color: AppColors.appbar,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'Aucun résultat trouvé',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                )),
              ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 1),
          height: 54,
          width: 54,
          child: FloatingActionButton(
            backgroundColor: AppColors.textFieldBackground,
            elevation: 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddScreenne()),
              );
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: AppColors.appbar),
              borderRadius: BorderRadius.circular(150),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.appbar,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.textFieldBackground,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black12,
          selectedItemColor: AppColors.appbar,
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
