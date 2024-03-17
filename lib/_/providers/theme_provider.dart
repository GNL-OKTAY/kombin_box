// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyThemes {
  static ThemeData DarkTheme = ThemeData(
    // app bar tema
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: Color.fromARGB(111, 0, 0, 0),
      foregroundColor: Color.fromARGB(221, 211, 211, 211),
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 224, 224, 224),
        fontSize: 19,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    ),
    scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
    // bottom app bar tema
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.black,
    ),
    primaryColor: Colors.black,
  );
  static ThemeData LightTheme = ThemeData(
    // app bar tema
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: mobileAppbarBackgroundColor,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xff686795),
        fontSize: 19,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
      foregroundColor: Colors.black87,
    ),
    scaffoldBackgroundColor: Colors.white,
    // bottom app bar tema
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
    primaryColor: Color.fromARGB(255, 255, 255, 255),
  );
}
