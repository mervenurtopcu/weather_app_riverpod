import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/product/constants/color_constants.dart';

import '../../product/constants/padding_constants.dart';
import '../../product/constants/string_constants.dart';
import 'settings_provider.dart';

class HomeWeatherView extends ConsumerStatefulWidget {
  const HomeWeatherView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends ConsumerState<HomeWeatherView> {
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
              Text(
                'Home Weather',
              ),
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
