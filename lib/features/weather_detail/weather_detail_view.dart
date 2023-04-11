import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../product/constants/color_constants.dart';
import '../../product/models/current_weather.dart';
import '../../product/services/network_service.dart';
import '../home_weather/settings_provider.dart';

class WeatherDetailView extends ConsumerStatefulWidget {
  const WeatherDetailView({
    required this.city,
    Key? key,
  }) : super(key: key);
    final String city;

  @override
  ConsumerState createState() => _WeatherDetailViewState();
}

class _WeatherDetailViewState extends ConsumerState<WeatherDetailView> {
  late final NetworkService _networkService;
  late Future<Weather?> weather;
  @override
  void initState() {
    super.initState();
    _networkService = NetworkService();
    weather = _networkService.getWeatherWithCityName( widget.city);
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
        appBar: AppBar(
          title: Text(widget.city,style: const TextStyle(color: Colors.black),),
        ),
        body: FutureBuilder<Weather?>(
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

          },
        ),
      ),
    );
  }
}
