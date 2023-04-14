import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/color_constants.dart';
import '../models/forecast_weather.dart';
import '../models/weather_icons.dart';

@immutable
class FiveDaysForecastListview extends StatelessWidget {
  const FiveDaysForecastListview(
      {Key? key, required this.dataList, required this.dayName})
      : super(key: key);
  final List<ForecastData>? dataList;
  final String dayName;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: dataList!.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.black.withOpacity(0.5),
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
                dayName == DateFormat.E().format(dataList![index].dateTime)
                    ? 'Today'
                    : DateFormat.EEEE().format(dataList![index].dateTime),
                style:
                    TextStyle(fontSize: 18, color: ColorsConstants.whiteColor)),
            leading: dataList![index].dateTime.hour >= 0 &&
                    dataList![index].dateTime.hour <= 6
                ? const Icon(
                    Icons.nights_stay,
                    color: Colors.white,
                  )
                : SizedBox(
                    height: 30,
                    child: getWeatherIcon(dataList![index].iconCode)),
            subtitle: Text('${dataList![index].dateTime.hour}:00',
                style: TextStyle(color: ColorsConstants.whiteColor)),
            trailing: Text(
              'min: ${dataList![index].minTemperature.toInt()}°' +
                  '\nmax: ${dataList![index].maxTemperature.toInt()}°',
              style: const TextStyle(color: Colors.white),
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
