import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SettingsProvider extends ChangeNotifier {

  var isDarkTheme = false;

  void setLightTheme() {
    isDarkTheme = false;
    notifyListeners();
  }
  void setDarkTheme() {
    isDarkTheme = true;
    notifyListeners();
  }
}
final settingsProvider = ChangeNotifierProvider((ref) => SettingsProvider());