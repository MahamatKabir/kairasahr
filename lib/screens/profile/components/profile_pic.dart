import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:heroicons/heroicons.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 50,
            right: -10,
            height: 200,
            width: 150,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo.shade50,
                    child: const HeroIcon(
                      // Utilisez HeroIcon à la place de SvgPicture.asset
                      HeroIcons
                          .user, // Utilisez l'icône directement, pas le chemin du fichier SVG
                      color: Colors.grey,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "ibrahim mahamat",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "ibrahim@gmail.com",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
