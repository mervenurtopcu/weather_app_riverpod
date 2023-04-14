import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/product/services/network_service.dart';

void main() {
  NetworkService networkService=NetworkService();
    setUp(() {

    });
    test('fetchForecastData Test', () async{
      var response=await networkService.fetchForecastData(city: 'Adana');
      expect(response, isNotNull);

    });
}