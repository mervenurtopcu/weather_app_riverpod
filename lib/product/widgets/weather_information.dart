import 'package:flutter/material.dart';
import 'package:weather_app/product/constants/index.dart';
import 'package:weather_app/product/models/current_weather.dart';
import '../constants/color_constants.dart';

@immutable
class WeatherInformation extends StatelessWidget {
  const WeatherInformation({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.paddingWeatherInformation,
      child: Center(
        child: Column(
          children: [
            Text(weather.cityName,
                style:
                    const TextStyle(fontSize: 20, color: ColorsConstants.whiteColor)),
            Text('${weather.temperature.toInt()}°',
                style:
                    const TextStyle(fontSize: 30, color: ColorsConstants.whiteColor)),
            Text(weather.description,
                style: const TextStyle(
                    fontSize: 20, color: ColorsConstants.whiteColor70)),
          ],
        ),
      ),
    );
  }
}
