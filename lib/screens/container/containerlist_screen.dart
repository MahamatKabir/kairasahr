import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/models/city_model.dart';
import 'package:kairasahrl/models/container_model.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/container/containerupdate.dart';
import 'package:kairasahrl/screens/fetchapi.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class ContainerListScreen extends StatefulWidget {
  static const routeName = "/ContainerListScreen";
  const ContainerListScreen({Key? key}) : super(key: key);

  @override
  State<ContainerListScreen> createState() => _ContainerListScreenState();
}

class _ContainerListScreenState extends State<ContainerListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<Conteneure> _containers = [];
  List<Conteneure> _filteredContainers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContainers();
  }

  void _loadContainers() async {
    try {
      List<Conteneure> containers = await YourApi.fetchContainers();
      setState(() {
        _containers = containers;
        _filteredContainers = List.from(containers);
      });
    } catch (e) {
      print('Failed to load containers: $e');
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void _filterContainers(String searchText) {
    _filteredContainers.clear();
    if (searchText.isEmpty) {
      setState(() {
        _filteredContainers.addAll(_containers);
      });
    } else {
      setState(() {
        _filteredContainers.addAll(_containers.where((container) =>
            container.name.toLowerCase().contains(searchText.toLowerCase()) ||
            container.customer
                .toLowerCase()
                .contains(searchText.toLowerCase())));
      });
    }
  }

  void _clearSearch() {
    _searchTextController.clear();
    _filterContainers('');
  }

  void deleteContainer(int id) {
    setState(() {
      _containers.removeWhere((container) => container.id == id);
      _filteredContainers.removeWhere((container) => container.id == id);
    });
  }

  City? city;

  void updateContainer(
    int id,
    String newName,
    String newPlaque,
    String newSlug,
    String newCustomer,
    String newCustomerTel,
    String newBroker,
    String newBrokerTel,
    double newAmount,
    String? cityID,
    int? contTypeID,
    //int? status,
    String newC,
    String newContDetails,
    String newCreatedAt,
  ) {
    setState(() {
      for (int i = 0; i < _containers.length; i++) {
        if (_containers[i].id == id) {
          _containers[i] = Conteneure(
            id: id,
            name: newName,
            plaque: newPlaque,
            slug: newSlug,
            customer: newCustomer,
            customerPhone: newCustomerTel,
            broker: newBroker,
            brokerPhone: newBrokerTel,
            containerPrice: newAmount,
            containerCityID: cityID,
            // containerType: contTypeID ?? 0,
            // status: status ?? 0,
            containerInformationC: newC,
            containerOtherDetails: newContDetails,
            createdAt: newCreatedAt,
            createdBy: _containers[i].createdBy,
            updatedAt: _containers[i].updatedAt,
            updatedBy: _containers[i].updatedBy,
          );
          break;
        }
      }
      _filterContainers(_searchTextController.text);
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
        title: const Text(
          'Liste des Conteneurs',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
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
                    onPressed: _clearSearch,
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
                        final containerdepense = _filteredContainers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContainerUpScreen(
                                  container: containerdepense,
                                  name: containerdepense.name,
                                  customer: containerdepense.customer,
                                  customerPhone: containerdepense.customerPhone,
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
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 3,
                                                  color: Colors.indigo.shade50,
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
                                              Container(
                                                width: 190,
                                                child: Text(
                                                  containerdepense.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const HeroIcon(
                                                    HeroIcons.viewColumns,
                                                    size: 10,
                                                    color: Colors.indigo,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    containerdepense.customer,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const HeroIcon(
                                                    HeroIcons.phoneArrowUpRight,
                                                    size: 10,
                                                    color: Colors.indigo,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    containerdepense
                                                        .customerPhone
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                              containerdepense.status == 'Actif'
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            containerdepense.status == 'Actif'
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
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}
