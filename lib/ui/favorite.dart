import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurants',
          style: TextStyle(fontFamily: "HellixBold"),
        ),
      ),
      body: Container(
        child: Consumer<AppProvider>(builder: (context, provider, _) {
          if (provider.stateFavourite == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.stateFavourite == ResultState.NoData) {
            return Center(
                child: Column(
              children: [
                Lottie.asset('assets/lottie/not_found.json'),
                Text(provider.message),
              ],
            ));
          } else if (provider.stateFavourite == ResultState.HasData) {
            List<Restaurant>? restaurants = provider.favoriteRestaurants;
            return ListView.builder(
              itemCount: restaurants!.length,
              itemBuilder: (BuildContext context, int index) {
                return RestaurantItem(
                  restaurant: restaurants[index],
                  provider: provider,
                );
              },
            );
          } else if (provider.stateFavourite == ResultState.Error) {
            return Center(child: Text(provider.message));
          }
          return Container();
        }),
      ),
    );
  }
}
