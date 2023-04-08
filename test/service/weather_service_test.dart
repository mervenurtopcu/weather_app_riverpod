import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/product/models/current_weather.dart';
import 'package:weather_app/product/services/current_weather_service.dart';

void main() {
  late CurrentWeatherService _currentWeatherService;
    setUp(() {
      _currentWeatherService = CurrentWeatherService();
    });
    test('Sample Test', () async{
      final response = await _currentWeatherService.getWeather('33.44', '-94.04');
      final cityName = response?.cityName;
      expect(cityName, 'Texarkana');
    });
}