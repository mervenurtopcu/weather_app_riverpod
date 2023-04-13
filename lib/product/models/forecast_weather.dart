import 'package:flutter/material.dart';
@immutable
class ForecastData {
  final DateTime dateTime;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double feelsLike;
  final double seaLevel;
  final double groundLevel;
  final int humidity;
  final int pressure;
  final String weatherDescription;
  final String iconCode;

  ForecastData({
    required this.dateTime,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.feelsLike,
    required this.seaLevel,
    required this.groundLevel,
    required this.humidity,
    required this.pressure,
    required this.weatherDescription,
    required this.iconCode,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      seaLevel: json['main']['sea_level'].toDouble(),
      groundLevel: json['main']['grnd_level'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      weatherDescription: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}
