import 'package:flutter/material.dart';
import 'package:ya_finance_app/presentation/home.dart';
import 'package:ya_finance_app/presentation/theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Finance App',
    theme: lightTheme,
    darkTheme: darkTheme,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  ));
}