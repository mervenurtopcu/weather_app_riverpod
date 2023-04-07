import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightTheme {

  final ThemeData lightTheme = ThemeData.light(
      useMaterial3: true,

  ).copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 150,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(

    ),);
}