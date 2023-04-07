import 'package:flutter/material.dart';
import 'package:weather_app/product/global/theme/light_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      themeMode: ThemeMode.system,
      //theme: LightTheme().lightTheme,
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
