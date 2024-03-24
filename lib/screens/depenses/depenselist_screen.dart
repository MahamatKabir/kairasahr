import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/depenses/depenseupdate_screen.dart';
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
  final List<Expense> _expense = [];

  List<Expense> _filteredExpenses = []; // Liste filtrée de dépenses

  @override
  void initState() {
    super.initState();
    _filteredExpenses.addAll(
        _expense); // Initialiser la liste filtrée avec toutes les dépenses
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  void _filterExpenses(String searchText) {
    setState(() {
      _filteredExpenses.clear(); // Effacer la liste filtrée actuelle

      // Parcourir toutes les dépenses et ajouter celles qui correspondent au critère de recherche
      for (Expense expense in _expense) {
        if (expense.article.toLowerCase().contains(searchText.toLowerCase()) ||
            expense.details
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            expense.paid
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase())) {
          _filteredExpenses.add(expense);
        }
      }
    });
  }

  void deleteExpense(int id) {
    setState(() {
      _expense.removeWhere((expense) => expense.id == id);
    });
  }

  void updateExpense(
    int id,
    String newArticle,
    String newDetails,
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
            details: newDetails,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 2, 95),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
            child: Text(
              'Liste des Dépenses      ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
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
                  onChanged: _filterExpenses,
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
                        _filterExpenses('');
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
                child: _filteredExpenses.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expenses = _filteredExpenses[index];
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
                                margin:
                                    const EdgeInsets.only(top: 10, left: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    "${expenses.details.toString()}FCFA",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
