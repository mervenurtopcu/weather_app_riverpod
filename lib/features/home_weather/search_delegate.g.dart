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
            Expanded(flex: 2, child: _weatherInformation(weather)),
            Expanded(
              flex: 2,
              child: hourly_suggestion(
                  forecastData: forecastData, isDarkTheme: isDarkTheme),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('5 Days Forecast',
                  style: TextStyle(
                      fontSize: 15, color: ColorsConstants.whiteColor)),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder<List<ForecastData>?>(
                  future: forecastData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<ForecastData>? _dataList = snapshot.data;

                        final now = DateTime.now();
                        String dayName = DateFormat.E().format(now);
                        return ListView.separated(
                          itemCount: _dataList!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.black.withOpacity(0.5),
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                    dayName ==
                                            DateFormat.E().format(
                                                _dataList[index].dateTime)
                                        ? 'Today'
                                        : DateFormat.EEEE()
                                            .format(_dataList[index].dateTime),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorsConstants.whiteColor)),
                                leading: _dataList[index].dateTime.hour >= 0 &&
                                        _dataList[index].dateTime.hour <= 6
                                    ? const Icon(
                                        Icons.nights_stay,
                                        color: Colors.white,
                                      )
                                    : SizedBox(
                                        height: 30,
                                        child: getWeatherIcon(
                                            _dataList[index].iconCode)),
                                subtitle:
                                    Text('${_dataList[index].dateTime.hour}:00',
                                        style: TextStyle(
                                            //fontSize: 20,
                                            color: ColorsConstants.whiteColor)),
                                trailing: Text(
                                  'min: ${_dataList[index].minTemperature.toInt()}°' +
                                      '\nmax: ${_dataList[index].maxTemperature.toInt()}°',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      );
    });

Padding _weatherInformation(Weather weather) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Center(
      child: Column(
        children: [
          //SizedBox(height: 100, child: getWeatherIcon(weather.iconCode)),
          Text(weather.cityName,
              style:
                  TextStyle(fontSize: 20, color: ColorsConstants.whiteColor)),
          Text('${weather.temperature.toInt()}°',
              style:
                  TextStyle(fontSize: 30, color: ColorsConstants.whiteColor)),
          Text(weather.description,
              style:
                  TextStyle(fontSize: 20, color: ColorsConstants.whiteColor70)),
        ],
      ),
    ),
  );
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
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black.withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                //spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              index == 0
                                  ? Text(
                                      'Now',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ColorsConstants.whiteColor),
                                    )
                                  : Text(
                                      '${_dataList![index].dateTime.hour}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ColorsConstants.whiteColor),
                                    ),
                              _dataList![index].dateTime.hour >= 0 &&
                                      _dataList[index].dateTime.hour <= 6
                                  ? Icon(
                                      Icons.nights_stay,
                                      color: Colors.white,
                                    )
                                  : SizedBox(
                                      height: 30,
                                      child: getWeatherIcon(
                                          _dataList[index].iconCode)),
                              Text('${_dataList[index].temperature.toInt()}°',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ColorsConstants.whiteColor)),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: 12);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No data'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
