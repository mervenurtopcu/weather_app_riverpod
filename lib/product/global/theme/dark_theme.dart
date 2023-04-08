import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
@immutable
class DarkTheme {

  DarkTheme._();
  static final ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
}