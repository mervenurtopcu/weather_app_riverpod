import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/product/models/current_weather.dart';
import 'package:weather_app/product/services/network_service.dart';
import '../global/geoLocator/geoLocator_manager.dart';

class WeatherManager {
  GeoLocatorManager location = GeoLocatorManager();
  NetworkService service = NetworkService();

  Future<Weather?> sendPositionToService() async {
    Position position = await location.determinePosition();
    var lat = position.latitude.toString();
    var lon = position.longitude.toString();
    var response= service.getWeather(lat, lon);
    return response;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
