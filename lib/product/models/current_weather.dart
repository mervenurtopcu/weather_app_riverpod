import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Weather  {
  final String cityName;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.iconCode,

  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }


  Widget getWeatherIcon(iconCode) {
      if(iconCode == '01d' || iconCode == '01n') {
      return Image.asset('assets/weather_icons/ic_sunny.png');
      } else if(iconCode == '02d' || iconCode == '02n') {
      return Image.asset('assets/weather_icons/ic_cloud_sunny.png');
      } else if(iconCode == '03d' || iconCode == '03n') {
      return Image.asset('assets/weather_icons/ic_cloud.png');
      } else if(iconCode == '04d' || iconCode == '04n') {
      return Image.asset('assets/weather_icons/ic_cloud.png');
      } else if(iconCode == '09d' || iconCode == '09n') {
      return Image.asset('assets/weather_icons/ic_sun_cloud_mid_rain.png');
      } else if(iconCode == '10d' || iconCode == '10n') {
      return Image.asset('assets/weather_icons/ic_sun_cloud_angled_rain.png');
      } else if(iconCode == '11d' || iconCode == '11n') {
      return Image.asset('assets/weather_icons/ic_tornado.png');
      } else if(iconCode == '13d' || iconCode == '13n') {
      return Image.asset('assets/weather_icons/ic_snow.png');
      } else if(iconCode == '50d' || iconCode == '50n') {
      return Image.asset('assets/weather_icons/ic_mist.png');
    }
      return Image.asset('assets/background_dark.jpg');
  }
}
