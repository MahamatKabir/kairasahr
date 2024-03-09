import 'package:flutter/material.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: const Size(327, 50),
    backgroundColor: Colors.indigo,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))));

final ButtonStyle buttonDelete = ElevatedButton.styleFrom(
    minimumSize: const Size(327, 50),
    backgroundColor: Colors.red,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))));
