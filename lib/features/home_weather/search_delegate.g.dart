part of 'search_delegate.dart';

Widget buildResultSuccess(Weather weather) =>
    Consumer(builder: (context, ref, child) {
      final NetworkService service=NetworkService();
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
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                        height: 100,
                        child: weather.getWeatherIcon(weather.iconCode)),
                    Text(weather.cityName,
                        style: TextStyle(
                            fontSize: 20, color: ColorsConstants.whiteColor)),
                    Text('${weather.temperature.toInt()}°',
                        style: TextStyle(
                            fontSize: 30, color: ColorsConstants.whiteColor)),
                    Text(weather.description,
                        style: TextStyle(
                            fontSize: 20, color: ColorsConstants.whiteColor70)),
                  ],
                )),
            Expanded(
              flex: 2,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: isDarkTheme ? Colors.cyan : Colors.deepOrange[100],
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
                              const Text('12:00',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              SizedBox(
                                  height: 30,
                                  child:
                                      weather.getWeatherIcon(weather.iconCode)),
                              Text('${weather.temperature.toInt()}°',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                  itemCount: 6),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      );
    });
