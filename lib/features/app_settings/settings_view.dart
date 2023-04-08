import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/app_settings/settings_provider.dart';
import 'package:weather_app/product/constants/padding_constants.dart';
import 'package:weather_app/product/constants/string_constants.dart';
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SettingsViewState();
}


class _SettingsViewState extends ConsumerState<SettingsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: PaddingConstants().paddingGeneral,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              StringConstants.themeSettings,style: TextStyle(fontSize: 18,color: Colors.purple),),
              //Divider(height: MediaQuery.of(context).size.width,color: Colors.purple,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Theme', style: TextStyle(fontSize: 18,color: Colors.purple),),
                Switch(
                  value: ref.watch(settingsProvider).isDarkTheme,
                  onChanged: (value) {
                    if(value) {
                      ref.read(settingsProvider).setDarkTheme();
                    } else {
                      ref.read(settingsProvider).setLightTheme();
                    }
                  },
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
