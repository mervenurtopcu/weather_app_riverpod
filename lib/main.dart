import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home_weather/home_weather_view.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
        home:HomeWeatherView()
    );
  }
}