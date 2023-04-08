import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:weather_app/product/constants/index.dart';

import '../models/current_weather.dart';
import 'package:dio/dio.dart';

class CurrentWeatherService {
  final _dio = Dio();

  Future<Weather?> getWeather(String lat, String lon) async {
    try {
      Response response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${StringConstants.apiKey}&units=metric');
      if (response.statusCode == HttpStatus.ok) {
        Weather weather= Weather.fromJson(response.data);
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
