import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/product/models/current_weather.dart';
import 'package:weather_app/product/services/network_service.dart';
import 'geoLocator_manager.dart';

class WeatherManager {
  GeoLocatorManager location = GeoLocatorManager();
  NetworkService service = NetworkService();

  Future<Weather> sendPositionToService() async {
     Position position = await location.determinePosition();

     var lat = position.latitude.toString();
     var lon = position.longitude.toString();
    var response= await service.getWeather(lat, lon);
    return response;
  }

}
