import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/home_weather/search_view/search_delegate.dart';
import '../../product/services/network_service.dart';
import 'theme_provider.dart';
import '../../product/constants/index.dart';
import '../../../product/widgets/index.dart';
import '../../../product/global/geoLocator/index.dart';
import '../../../product/models/index.dart';
import '../../../product/shimmers/index.dart';
class HomeWeatherView extends ConsumerStatefulWidget {
  const HomeWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends ConsumerState<HomeWeatherView> {
  late Future<Weather> weather;
  WeatherManager weatherManager = WeatherManager();

  @override
  void initState() {
    super.initState();
    weather = weatherManager.sendPositionToService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: ref.watch(settingsProvider).isDarkTheme
          ? const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background_dark.jpg'),
              ),
            )
          : const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background_light.jpg'),
              ),
            ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          backgroundColor: ColorsConstants.transparent,
          appBar: AppBar(
            title: const Text(StringConstants.appTitle),
            backgroundColor: ColorsConstants.transparent,
            actions: [
              ref.watch(settingsProvider).isDarkTheme
                  ? IconButton(
                      icon: const Icon(Icons.nights_stay_outlined),
                      onPressed: () {
                        _showModalBottomSheet(context);
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.wb_sunny_outlined,
                        color: ColorsConstants.yellowColor,
                      ),
                      onPressed: () {
                        _showModalBottomSheet(context);
                      },
                    ),
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: CitySearch());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: ColorsConstants.whiteColor,
                  ))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: FutureBuilder<Weather>(
                    future: weather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return WeatherInformation(weather: snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const ShimmerWeatherInformation();
                      }
                    }),
              ),
              Expanded(
                flex: 2,
                child: FutureBuilder<List<ForecastData>?>(
                    future: weatherManager.sendPositionToService().then(
                        (value) => NetworkService()
                            .fetchForecastData(city: value.cityName)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ForecastData>? _dataList = snapshot.data;
                        return HourlyListView(
                            itemCount: 12, dataList: _dataList);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const ShimmerHourlyListView();
                      } else {
                        return const Center(
                            child: Text(StringConstants.noData));
                      }
                    }),
              ),
              Padding(
                padding: PaddingConstants.paddingGeneral,
                child: const Text(StringConstants.forecast,
                    style: TextStyle(
                        fontSize: 15, color: ColorsConstants.whiteColor)),
              ),
              Expanded(
                  flex: 4,
                  child: FutureBuilder<List<ForecastData>?>(
                      future: weatherManager.sendPositionToService().then(
                          (value) => NetworkService()
                              .fetchForecastData(city: value.cityName)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ForecastData>? _dataList = snapshot.data;
                          final now = DateTime.now();
                          String dayName = DateFormat.E().format(now);
                          return FiveDaysForecastListview(
                              dataList: _dataList, dayName: dayName);
                        }
                        return ShimmerFiveDaysForecast();
                      }))
            ],
          )),
    );
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
                      color: ColorsConstants.dividerColor,
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
                      padding: PaddingConstants.paddingGeneral,
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
