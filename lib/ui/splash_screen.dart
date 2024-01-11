import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = "/splash_screen";
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    openHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: kOrangeColor,
            body: SafeArea(
                child: Center(
                    child: Container(
              padding: const EdgeInsets.all(0.0),
              width: 300,
              height: 500,
              child: Column(
                children: [
                  Lottie.asset('assets/json/resto.json'),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    'All In',
                    style: TextStyle(
                        fontFamily: 'HellixBold',
                        fontSize: 50,
                        color: kLightColor,
                        letterSpacing: 2.0),
                  )
                ],
              ),
            )))));
  }







  openHome() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Provider.of<AppProvider>(context, listen :false).getRestaurants();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ListPage(),
          ),
          (route) => false);
    });
  }


}
