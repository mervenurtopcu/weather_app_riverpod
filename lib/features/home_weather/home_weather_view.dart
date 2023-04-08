import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/product/global/geoLocator/geoLocator_manager.dart';
import 'package:weather_app/product/services/current_weather_service.dart';
import '../../product/models/current_weather.dart';
import 'settings_provider.dart';
import '../../product/constants/index.dart';
import 'package:geolocator/geolocator.dart';

class HomeWeatherView extends ConsumerStatefulWidget {
  const HomeWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends ConsumerState<HomeWeatherView> {

  late final _geoLocatorManager;

  @override
  void initState() {
    super.initState();
    _geoLocatorManager = GeoLocatorManager();

  }

Future<Weather?> getCurrentWeather()async {
    final CurrentWeatherService _currentWeatherService = CurrentWeatherService();
    Position position = _geoLocatorManager.determinePosition();
    var lat = position.latitude.toString();
    var lon = position.longitude.toString();
    var response= _currentWeatherService.getWeather(lat, lon);
    // position.then((value) {
    //   String lat = value.latitude.toString();
    //   String lon = value.longitude.toString();
    // var response= _currentWeatherService.getWeather(lat, lon);
    // return response;
    // });
    return response;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            ref.watch(settingsProvider).isDarkTheme
                ? IconButton(
                    icon: const Icon(Icons.nights_stay_outlined),
                    onPressed: () {
                      _showModalBottomSheet(context);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.wb_sunny_outlined),
                    onPressed: () {
                      _showModalBottomSheet(context);
                    },
                  )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             FutureBuilder(
               future: getCurrentWeather(),
               builder: (context, snapshot){
                 if(snapshot.hasData){
                   final weather =snapshot.data;
                   return Text(weather!.description);
                 }else{
                   return Text('no data');
                 }
               },
             )
            ],
          ),
        ));
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      color:ColorsConstants.dividerColor,
                      thickness: 4,
                      indent: MediaQuery.of(context).size.width * 0.45,
                      endIndent: MediaQuery.of(context).size.width * 0.45,
                    ),
                    Text(
                        StringConstants.darkMode,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: PaddingConstants().paddingGeneral,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringConstants.darkMode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.normal)),
                          Switch(
                            value: ref.watch(settingsProvider).isDarkTheme,
                            onChanged: (value) {
                              if (value) {
                                ref.read(settingsProvider).setDarkTheme();
                              } else {
                                ref.read(settingsProvider).setLightTheme();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }


}
