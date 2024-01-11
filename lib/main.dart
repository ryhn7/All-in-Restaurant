import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/categori.dart';
import 'package:restaurant_app/data/model/menu.dart';
import 'package:restaurant_app/data/model/menus.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/utils/config.dart';

import 'data/api/api.service.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final NotificationHelper _notificationHelper = NotificationHelper();
  // final BackgroundService _service = BackgroundService();

  // _service.initializeIsolate();

  // if (Platform.isAndroid) await AndroidAlarmManager.initialize();

  // await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(MenusAdapter());
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ReviewAdapter());
  await Hive.openBox(Configuration.Box_Fav);
  await Hive.openBox(Configuration.Box_Dark_Mode);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) {
            return AppProvider(apiService: ApiService());
          },
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box(Configuration.Box_Dark_Mode).listenable(),
        builder: (context, Box box, child) {
          var darkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp(
            builder: (context, widget) => ResponsiveBreakpoints.builder(
              child: widget!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              ],
              // backgroundColor: primaryColor,
            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                    restaurant: ModalRoute.of(context)?.settings.arguments
                        as Restaurant,
                  ),
            },
            debugShowCheckedModeBanner: false,
            title: 'All In',
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              primaryColor: kOrangeColor,
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: "Hellix",
              appBarTheme: AppBarTheme(
                elevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                  textStyle: TextStyle(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
            darkTheme: ThemeData.dark(),
            home: SplashScreen(),
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
