import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home_weather/home_weather_view.dart';
import 'package:weather_app/product/global/theme/dark_theme.dart';
import 'package:weather_app/product/global/theme/light_theme.dart';
import 'features/home_weather/theme_provider.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      title: 'Material App',
      theme: ref.watch(settingsProvider).isDarkTheme ? DarkTheme.darkTheme :LightTheme.lightTheme,
      debugShowCheckedModeBanner: false,
        home:const HomeWeatherView()

    );
  }
}