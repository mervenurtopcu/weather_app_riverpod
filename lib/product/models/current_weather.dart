import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Weather extends Equatable {
  final String cityName;
  final String description;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }

  @override
  List<Object?> get props => [
        cityName,
        description,
        temperature,
        humidity,
        windSpeed,
        iconCode,
      ];
}
