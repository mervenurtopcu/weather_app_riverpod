part of 'search_delegate.dart';

Widget buildResultSuccess(Weather weather) =>
    Consumer(builder: (context, ref, child) {
      final NetworkService service = NetworkService();
      final forecastData = service.fetchForecastData(city: weather.cityName);
      final isDarkTheme = ref.watch(settingsProvider).isDarkTheme;

      return Container(
        decoration: isDarkTheme
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
              )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: WeatherInformation(weather: weather)),
            Expanded(
              flex: 2,
              child: hourly_suggestion(
                  forecastData: forecastData, isDarkTheme: isDarkTheme),
            ),
            Padding(
              padding: PaddingConstants.paddingGeneral,
              child: const Text(StringConstants.forecast,
                  style: TextStyle(
                      fontSize: 15, color: ColorsConstants.whiteColor)),
            ),
            Expanded(
              flex: 4,
              child: _fiveDaysForecast(forecastData: forecastData),
            ),
          ],
        ),
      );
    });

class _fiveDaysForecast extends StatelessWidget {
  const _fiveDaysForecast({
    super.key,
    required this.forecastData,
  });

  final Future<List<ForecastData>?> forecastData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ForecastData>?>(
        future: forecastData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<ForecastData>? _dataList = snapshot.data;
              final now = DateTime.now();
              String dayName = DateFormat.E().format(now);
              return FiveDaysForecastListview(dataList: _dataList, dayName: dayName);
            }
          }
          return const Center(child: CircularProgressIndicator(color: ColorsConstants.whiteColor,strokeWidth: 2,));
        });
  }
}



class hourly_suggestion extends StatelessWidget {
  const hourly_suggestion({
    super.key,
    required this.forecastData,
    required this.isDarkTheme,
  });

  final Future<List<ForecastData>?> forecastData;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ForecastData>?>(
        future: forecastData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<ForecastData>? _dataList = snapshot.data;
              return HourlyListView(itemCount: 12, dataList: _dataList);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: ColorsConstants.whiteColor,strokeWidth: 2,));
            } else {
              return const Center(child: Text(StringConstants.noData));
            }
          }
          return const Center(child: CircularProgressIndicator(color: ColorsConstants.whiteColor,strokeWidth: 2,));
        });
  }
}
