import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../app_settings/settings_view.dart';
class HomeWeatherView extends ConsumerStatefulWidget {
  const HomeWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends ConsumerState<HomeWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.nights_stay_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
          ),],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Weather',
            ),
          ],
        ),
      )
    );
  }
}
