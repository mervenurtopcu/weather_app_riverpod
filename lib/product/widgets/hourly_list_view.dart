import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../models/forecast_weather.dart';
import '../models/weather_icons.dart';

@immutable
class HourlyListView extends StatelessWidget {
  const HourlyListView(
      {Key? key, required this.itemCount, required this.dataList})
      : super(key: key);
  final int itemCount;
  final List<ForecastData>? dataList;

  @override
  Widget build(BuildContext context) {
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
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
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
                            '${dataList![index].dateTime.hour}',
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorsConstants.whiteColor),
                          ),
                    dataList![index].dateTime.hour >= 0 &&
                            dataList![index].dateTime.hour <= 6
                        ? const Icon(
                            Icons.nights_stay,
                            color: Colors.white,
                          )
                        : SizedBox(
                            height: 30,
                            child: getWeatherIcon(dataList![index].iconCode)),
                    Text('${dataList![index].temperature.toInt()}°',
                        style: TextStyle(
                            fontSize: 16, color: ColorsConstants.whiteColor)),
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
        itemCount: itemCount);
  }
}
