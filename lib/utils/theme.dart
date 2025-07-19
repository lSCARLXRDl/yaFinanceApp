import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get systemThemeLight => ThemeData.light().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFF3EDF7),
        unselectedItemColor: Color(0xFF49454F),
      ),
      scaffoldBackgroundColor: Color(0xFFFEF7FF),
      cardColor: Color(0xFFFEF7FF),

      textTheme: TextTheme(
        titleSmall: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      )
  );

  static ThemeData get systemThemeDark => ThemeData.dark().copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF49454F),
      unselectedItemColor: Color(0xFFF3EDF7),
    ),
    scaffoldBackgroundColor: Color(0xFF353335),
    cardColor: Color(0xFF353335),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Color(0xFFD8D5DD),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: Color(0xFFD8D5DD),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    )
  );

  static ThemeData get customLightTheme => ThemeData.light().copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF3EDF7),
      unselectedItemColor: Color(0xFF49454F),
    ),
    scaffoldBackgroundColor: Color(0xFFFEF7FF),
    cardColor: Color(0xFFFEF7FF),

    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    )
  );
}