import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kairasahrl/screens/profile/userDetailscreen.dart';
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
      backgroundColor: Colors.indigo.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 100),
            ProfileMenu(
              text: "Détails de l'utilisateur",
              icon: Icons.person, // Utilisez l'icône IconData directement
              press: () {
                // Naviguer vers la page de détails de l'utilisateur lorsque l'élément est sélectionné
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDetailScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Déconnecter",
              icon: Icons.logout, // Utilisez l'icône IconData directement
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
