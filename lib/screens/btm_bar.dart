import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:kairasahrl/screens/addscreen.dart';
import 'package:kairasahrl/screens/home.dart';
import 'package:kairasahrl/screens/profile/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const MyHomePage(), 'title': 'Home Screen'},
    {'page': const ProfileScreen(), 'title': 'user Screen'},
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Bloquer le retour en arrière depuis l'écran principal
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text( _pages[_selectedIndex]['title']),
        // ),
        body: _pages[_selectedIndex]['page'],
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
          onTap: _selectedPage,
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
        ),
      ),
    );
  }
}
