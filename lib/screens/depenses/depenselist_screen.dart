import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/depenses/depenseupdate_screen.dart';
import 'package:kairasahrl/screens/profile/profile_screen.dart';
import 'package:kairasahrl/widget/sizedtext.dart';

class DepenseListScreen extends StatefulWidget {
  static const routeName = "/DepenseListScreen";
  const DepenseListScreen({super.key});

  @override
  State<DepenseListScreen> createState() => _DepenseListScreenState();
}

class _DepenseListScreenState extends State<DepenseListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  final List<Expense> _expense = [
    Expense(
      id: 1,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 2000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 2,
      article: 'Achat de fournitures',
      slug: 'achat_fournitures_bureau',
      total: 90000,
      paid: 150,
      containerID: 3,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 700000,
      paid: 150,
      containerID: 2,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),
    Expense(
      id: 3,
      article: 'Achat de fournitures de l ambasssade de france',
      slug: 'achat_fournitures_bureau',
      total: 3000000,
      paid: 150,
      containerID: 4,
      createdBy: 1,
      createdAt: '2024-02-17',
      updatedBy: 1,
      updatedAt: '2024-02-17',
    ),

    // Add more Container objects if needed
  ];

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void deleteExpense(int id) {
    setState(() {
      _expense.removeWhere((expense) => expense.id == id);
    });
  }

  void updateExpense(
    int id,
    String newArticle,
    String newSlug,
    int newTotal,
    int newPaid,
    int newContainerID,
    int newCreatedBy,
    String newCreatedAt,
    int newUpdatedBy,
    String newUpdatedAt,
  ) {
    setState(() {
      for (int i = 0; i < _expense.length; i++) {
        if (_expense[i].id == id) {
          _expense[i] = Expense(
            id: id,
            article: newArticle,
            slug: newSlug,
            total: newTotal,
            paid: newPaid,
            containerID: newContainerID,
            createdBy: newCreatedBy,
            createdAt: newCreatedAt,
            updatedBy: newUpdatedBy,
            updatedAt: newUpdatedAt,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 0, 66),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Liste des Depenses',
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
                removeTop: true,
                child: ListView.builder(
                  itemCount: _expense.length,
                  itemBuilder: (context, index) {
                    final expenses = _expense[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to container details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepenseUpScreen(
                              expense: expenses,
                              onDelete: deleteExpense,
                              onUpdate: updateExpense,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 71,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(5, 5),
                              spreadRadius: 5.0,
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                              expenses.article,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedText(
                                              text:
                                                  'creer le ${expenses.createdAt}',
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
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 27,
                                        child: Center(
                                          child: Container(
                                            width: 200,
                                            child: Text(
                                              "${expenses.total.toString()}FCFA",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
}
