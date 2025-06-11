import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF2AE881),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF3EDF7),
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData darkTheme = ThemeData();