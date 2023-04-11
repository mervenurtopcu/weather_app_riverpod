import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/current_weather.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
const String apiKey = 'aab622d77789e79c2327f62c0d92706c';

class NetworkService {
  final _dio = Dio();

  static Future<List<String>> searchCities({required String query}) async {
    const limit = 3;
    final url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<String>((json) {
      final city = json['name'];
      final country = json['country'];

      return '$city, $country';
    }).toList();
  }


  static Future<Weather> getWeathers({required String city}) async {
    final url =
        '$openWeatherMapUrl?q=$city&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return Weather.fromJson(body);


  }


  Future<Weather?> getWeather(String lat, String lon) async {
    try {
      Response response = await _dio.get(
          '$openWeatherMapUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
      if (response.statusCode == HttpStatus.ok) {
        Weather weather = Weather.fromJson(response.data);
        return weather;
      }
    } on DioError catch (e) {
      _ShowDebug.showDioError(e, this);
    }
    return null;
  }

   Future<Weather?> getWeatherWithCityName(String cityName) async {
    try {
      Response response = await _dio.get(
          '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
      if (response.statusCode == HttpStatus.ok) {
        Weather weather = Weather.fromJson(response.data);
        return weather;
      }
    } on DioError catch (e) {
      _ShowDebug.showDioError(e, this);
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError<T>(DioError error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('-----');
    }
  }
}
