import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home_weather/theme_provider.dart';
import 'package:weather_app/product/models/forecast_weather.dart';
import 'package:weather_app/product/services/network_service.dart';
import '../../../product/models/current_weather.dart';
import 'package:intl/intl.dart';
import '../../../product/constants/index.dart';
import '../../../product/widgets/index.dart';
import '../../../product/shimmers/index.dart';

part 'search_delegate.g.dart';

class CitySearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<Weather>(
        future: NetworkService.getWeathers(city: query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: const Text(
                    StringConstants.error,
                    style: TextStyle(
                        fontSize: 28, color: ColorsConstants.whiteColor),
                  ),
                );
              } else {
                return buildResultSuccess(snapshot.data!);
              }
          }
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.transparent,
        child: FutureBuilder<List<String>>(
          future: NetworkService.searchCities(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                  color: ColorsConstants.whiteColor,
                  strokeWidth: 2,
                ));
              default:
                if (snapshot.hasError || snapshot.data == null) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data!);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => const Center(
        child: Text(
          StringConstants.noSuggestions,
          style: TextStyle(fontSize: 18, color: ColorsConstants.whiteColor),
        ),
      );

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            leading: const Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: ColorsConstants.bluegreyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: ColorsConstants.greyColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
