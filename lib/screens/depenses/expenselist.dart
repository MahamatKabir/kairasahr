import 'dart:convert';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kairasahrl/models/depense_model.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/btm_bar.dart';
import 'package:kairasahrl/screens/depenses/expensedetail.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  late Future<List<Expenses>> futureExpenses;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureExpenses = fetchExpenses();
  }

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

  Future<List<Expenses>> fetchExpenses() async {
    final response = await http
        .get(Uri.parse('http://kairasarl.yerimai.com/api/v1/expenses'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> data = responseData[
          'data']; // Assurez-vous d'adapter cette partie selon la structure de vos données JSON
      List<Expenses> expenses = data.map((e) => Expenses.fromJson(e)).toList();
      return expenses;
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: FutureBuilder<List<Expenses>>(
          future: futureExpenses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erreur: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Expenses expense = snapshot.data![index];
                  return ListTile(
                    title: Text(expense.article),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Montant payé: ${expense.amountPaid.toString()}'),
                        Text('Conteneur: ${expense.expenseType}'),
                        Text('Créé par: ${expense.createdBy}'),
                        Text('Détails: ${expense.details}'),
                        Text('Date de création: ${expense.createdAt}'),
                        // Text('Type: ${expense.type}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExpenseDetailPage(expense: expense)),
                      );
                    },
                  );
                },
              );
            }
          },
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
