import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/product/services/current_weather_manager.dart';
import '../../product/models/current_weather.dart';
import 'settings_provider.dart';
import '../../product/constants/index.dart';

class HomeWeatherView extends ConsumerStatefulWidget {
  const HomeWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends ConsumerState<HomeWeatherView> {
  late Future<Weather?> weather;
  WeatherManager weatherManager = WeatherManager();

  @override
  void initState() {
    super.initState();
    weather = weatherManager.sendPositionToService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: ref.watch(settingsProvider).isDarkTheme
          ? const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background_dark.jpg'),
              ),
            )
          : const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background_light.jpg'),
              ),
            ),
      child: Scaffold(
          backgroundColor:ColorsConstants.transparent,
          appBar: AppBar(
            title: const Text(StringConstants.appTitle),
            backgroundColor: ColorsConstants.transparent,
            toolbarHeight: 150,
            bottom: search_widget(),
            actions: [
              ref.watch(settingsProvider).isDarkTheme
                  ? IconButton(
                      icon: const Icon(Icons.nights_stay_outlined),
                      onPressed: () {
                        _showModalBottomSheet(context);
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.wb_sunny_outlined),
                      onPressed: () {
                        _showModalBottomSheet(context);
                      },
                    )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                    future: weather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Text(snapshot.data!.cityName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: ColorsConstants.whiteColor)),
                              Text('${snapshot.data!.temperature.toInt()}°',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: ColorsConstants.whiteColor)),
                              Text(snapshot.data!.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: ColorsConstants.whiteColor70)),

                              // Text(snapshot.data!.humidity.toString()),
                              // Text(snapshot.data!.windSpeed.toString()),
                              // Image.network('https://openweathermap.org/img/w/${snapshot.data!.iconCode}.png'),
                            ],
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            ),
          )),
    );
  }

  PreferredSize search_widget() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: PaddingConstants().paddingSearchView,
          child: TextField(
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color:ColorsConstants.whiteColor,fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                hintText: StringConstants.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ));
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      color: ColorsConstants.dividerColor,
                      thickness: 4,
                      indent: MediaQuery.of(context).size.width * 0.45,
                      endIndent: MediaQuery.of(context).size.width * 0.45,
                    ),
                    Text(
                      StringConstants.darkMode,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: PaddingConstants().paddingGeneral,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringConstants.darkMode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.normal)),
                          Switch(
                            value: ref.watch(settingsProvider).isDarkTheme,
                            onChanged: (value) {
                              if (value) {
                                ref.read(settingsProvider).setDarkTheme();
                              } else {
                                ref.read(settingsProvider).setLightTheme();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
