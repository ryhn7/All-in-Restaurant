import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
        style: TextStyle(
          fontFamily: "HellixBold"
        ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => SettingProvider(),
        child: ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Dark Theme'),
                trailing: Consumer<SettingProvider>(
                  builder: (context, provider, _) {
                    return Switch.adaptive(
                      onChanged: (value) async {
                        provider.setDarkMode(value);
                      },
                      value: provider.isDarkMode(),
                    );
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Scheduling Promo'),
                // trailing: Consumer<SettingProvider>(
                //   builder: (context, scheduled, _) {
                //     return Switch.adaptive(
                //       value: scheduled.isScheduled,
                //       onChanged: (value) async {
                //         if (Platform.isIOS) {
                //           customDialog(context);
                //         } else {
                //           scheduled.scheduledInfo(value);
                //         }
                //       },
                //     );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}