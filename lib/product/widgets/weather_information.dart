import 'package:flutter/material.dart';
import 'package:weather_app/product/models/current_weather.dart';
import '../constants/color_constants.dart';

@immutable
class WeatherInformation extends StatelessWidget {
  const WeatherInformation({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Column(
          children: [
            Text(weather.cityName,
                style:
                    TextStyle(fontSize: 20, color: ColorsConstants.whiteColor)),
            Text('${weather.temperature.toInt()}°',
                style:
                    TextStyle(fontSize: 30, color: ColorsConstants.whiteColor)),
            Text(weather.description,
                style: TextStyle(
                    fontSize: 20, color: ColorsConstants.whiteColor70)),
          ],
        ),
      ),
    );
  }
}
