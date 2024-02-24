import 'package:flutter/material.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 100),
            ProfileMenu(
              text: "Liste des contenairs",
              icon:
                  Icons.cabin_outlined, // Utilisez l'icône IconData directement
              press: () => {},
            ),
            ProfileMenu(
              text: "Liste des depenses",
              icon: Icons.payment, // Utilisez l'icône IconData directement
              press: () {},
            ),
            ProfileMenu(
              text: "Liste des villes",
              icon:
                  Icons.location_city, // Utilisez l'icône IconData directement
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout, // Utilisez l'icône IconData directement
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
