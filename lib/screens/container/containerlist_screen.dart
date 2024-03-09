import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/container/containerupdate.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class ContainerListScreen extends StatefulWidget {
  static const routeName = "/ContainerListScreen";
  const ContainerListScreen({super.key});

  @override
  State<ContainerListScreen> createState() => _ContainerListScreenState();
}

class _ContainerListScreenState extends State<ContainerListScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  final FocusNode _searchTextFocusNode = FocusNode();
  final List<Containere> _containers = [
    Containere(
      id: 1,
      name: 'Viande Container',
      slug: 'container_1',
      customer: 'İssa mahamat',
      customerTel: 1234567890,
      broker: 'John Doe',
      brokerTel: 9876543210,
      amount: 50000.0,
      cityID: 1,
      contTypeID: 1,
      status: 0,
      newC: '1234',
      contDetails: 'Details about the container...',
      createdBy: null,
      createdAt: '2024-02-06',
      updatedBy: null,
      updatedAt: null,
    ),
    Containere(
      id: 2,
      name: 'Furniture Container',
      slug: 'container_2',
      customer: 'Alice Smith',
      customerTel: 9876543210,
      broker: 'Jane Doe',
      brokerTel: 1234567890,
      amount: 75000.0,
      cityID: 2,
      contTypeID: 0,
      status: 1,
      newC: '5678',
      contDetails: 'Details about the container...',
      createdBy: null,
      createdAt: '2024-02-10',
      updatedBy: null,
      updatedAt: null,
    ),
    Containere(
      id: 3,
      name: 'Electronics Container',
      slug: 'container_3',
      customer: 'Michael Johnson',
      customerTel: 5556667777,
      broker: 'Chris Brown',
      brokerTel: 3334445555,
      amount: 100000.0,
      cityID: 3,
      contTypeID: 1,
      status: 1,
      newC: '9876',
      contDetails: 'Details about the container...',
      createdBy: null,
      createdAt: '2024-02-15',
      updatedBy: null,
      updatedAt: null,
    ),
    Containere(
      id: 4,
      name: 'Clothing Container',
      slug: 'container_4',
      customer: 'Emily Wilson',
      customerTel: 4447778888,
      broker: 'Jessica Parker',
      brokerTel: 9998887777,
      amount: 60000.0,
      cityID: 1,
      contTypeID: 0,
      status: 0,
      newC: '2468',
      contDetails: 'Details about the container...',
      createdBy: null,
      createdAt: '2024-02-20',
      updatedBy: null,
      updatedAt: null,
    ),
    Containere(
      id: 5,
      name: 'Food Container',
      slug: 'container_5',
      customer: 'David Brown',
      customerTel: 3332221111,
      broker: 'Matthew Johnson',
      brokerTel: 6665554444,
      amount: 80000.0,
      cityID: 2,
      contTypeID: 1,
      status: 1,
      newC: '1357',
      contDetails: 'Details about the container...',
      createdBy: null,
      createdAt: '2024-02-25',
      updatedBy: null,
      updatedAt: null,
    ),
    Containere(
      id: 6,
      name: 'Chemical Container',
      slug: 'container_6',
      customer: 'Sophia Martinez',
      customerTel: 123245685,
      broker: 'Oliver Garcia',
      brokerTel: 2223334444,
      amount: 90000.0,
      cityID: 3,
      contTypeID: 1,
      status: 0,
      newC: '3691',
      contDetails:
          'Réaction chimique, catalyseur, équilibre, molécules, réactifs, produits, température, pression, cinétique, énergie, liaison, électrons.',
      createdBy: null,
      createdAt: '2024-02-28',
      updatedBy: null,
      updatedAt: null,
    ),
  ];

  List<Containere> _filteredContainers = [];
  @override
  void initState() {
    super.initState();
    _filteredContainers.addAll(
        _containers); // Initialiser la liste filtrée avec tous les conteneurs
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void _filterContainers(String searchText) {
    _filteredContainers.clear(); // Effacer la liste filtrée actuelle

    // Parcourir tous les conteneurs et ajouter ceux qui correspondent au critère de recherche
    for (Containere container in _containers) {
      if (container.name.toLowerCase().contains(searchText.toLowerCase()) ||
          container.customer.toLowerCase().contains(searchText.toLowerCase())) {
        _filteredContainers.add(container);
      }
    }
    setState(
        () {}); // Mettre à jour l'interface utilisateur avec les conteneurs filtrés
  }

  void _clearSearch() {
    _searchTextController.clear(); // Effacer le texte de recherche
    _filterContainers(
        ' '); // Réinitialiser la liste filtrée pour afficher tous les conteneurs
  }

  void deleteContainer(int id) {
    setState(() {
      _containers.removeWhere((container) => container.id == id);
    });
  }

  void updateContainer(
    int id,
    String newName,
    String newSlug,
    String newCustomer,
    int newCustomerTel,
    String newBroker,
    int newBrokerTel,
    double newAmount,
    int cityID,
    int contTypeID,
    int status,
    String newC,
    String newContDetails,
    String newCreatedAt,
  ) {
    setState(() {
      for (int i = 0; i < _containers.length; i++) {
        if (_containers[i].id == id) {
          _containers[i] = Containere(
            id: id,
            name: newName,
            slug: newSlug,
            customer: newCustomer,
            customerTel: newCustomerTel,
            broker: newBroker,
            brokerTel: newBrokerTel,
            amount: newAmount,
            cityID: cityID,
            contTypeID: contTypeID,
            status: status,
            newC: newC,
            contDetails: newContDetails,
            createdAt: newCreatedAt,
            createdBy: _containers[i].createdBy,
            updatedAt: _containers[i].updatedAt,
            updatedBy: _containers[i].updatedBy,
          );
          break;
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
          backgroundColor: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Liste des Conteneurs',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (value) {
                        _filterContainers(value);
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
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.indigo,
                        ),
                        suffix: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed:
                              _clearSearch, // Appeler la fonction pour effacer la recherche
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: _filteredContainers.isNotEmpty
                        ? ListView.builder(
                            itemCount: _filteredContainers.length,
                            itemBuilder: (context, index) {
                              final containerdepense =
                                  _filteredContainers[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to container details screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContainerUpScreen(
                                        container: containerdepense,
                                        name: containerdepense.name,
                                        customer: containerdepense.customer,
                                        customerTel: containerdepense
                                            .customerTel
                                            .toString(),
                                        createdAt: containerdepense.createdAt,
                                        onDelete: deleteContainer,
                                        onUpdate: updateContainer,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 100,

                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(248, 255, 254, 254),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        width: 3,
                                                        color: Colors
                                                            .indigo.shade50,
                                                      ),
                                                      image: const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "assets/images/cont.png"))),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      containerdepense.name,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const HeroIcon(
                                                          HeroIcons
                                                              .viewColumns, // Choisissez l'icône que vous souhaitez afficher
                                                          size:
                                                              10, // Taille de l'icône
                                                          color: Colors
                                                              .indigo, // Couleur de l'icône
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          containerdepense
                                                              .customer,
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const HeroIcon(
                                                          HeroIcons
                                                              .phoneArrowUpRight, // Choisissez l'icône que vous souhaitez afficher
                                                          size:
                                                              10, // Taille de l'icône
                                                          color: Colors
                                                              .indigo, // Couleur de l'icône
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          containerdepense
                                                              .customerTel
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedText(
                                                        text: containerdepense
                                                            .createdAt,
                                                        color: Colors.green)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    containerdepense.status == 1
                                                        ? Colors.green
                                                        : Colors.red,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  containerdepense.status == 1
                                                      ? 'Active'
                                                      : 'Passive',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20, left: 20),
                                              width: 40,
                                              height: 30,
                                              child: const Center(
                                                child: HeroIcon(
                                                  HeroIcons.chevronRight,
                                                  size: 22,
                                                  color: Colors.indigo,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // child: Padding(
                                  //   padding: const EdgeInsets.all(16.0),
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         container.name,
                                  //         style: const TextStyle(
                                  //           fontFamily: 'Varela',
                                  //           fontSize: 20,
                                  //           color: Color.fromARGB(255, 10, 2, 52),
                                  //         ),
                                  //       ),
                                  //       Text(container.slug),
                                  //       const Icon(Icons.arrow_forward_ios),
                                  //     ],
                                  //   ),
                                  // ),
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
                  ),
                ),
              ],
            ),
            //buildBottomBarScreen(),
          ]),
        ),
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

//   _listcontainer() {
//     return Positioned(
//       top: 320,
//       child: Container(
//         height: 130,
//         width: MediaQuery.of(context).size.width - 20,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 bottomRight: Radius.circular(30)),
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0xFFd8dbe0),
//                   offset: Offset(1, 1),
//                   blurRadius: 20.0,
//                   spreadRadius: 10),
//             ]),
//         child: Container(
//           margin: const EdgeInsets.only(top: 10, left: 18),
//           child: Row(children: [
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             width: 3,
//                             color: Colors.grey,
//                           ),
//                           image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage("images/background.png"))),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "kengne",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.mainColor),
//                         ),
//                         Text(
//                           "id: 123457",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppColor.mainColor),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             )
//           ]),
//         ),
//       ),
//     );
//   }
//
}
