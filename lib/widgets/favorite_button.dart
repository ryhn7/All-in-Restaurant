import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;
  final AppProvider provider;

  const FavoriteButton({required this.restaurant, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<AppProvider>(builder: (context, provider, _) {
          if (provider.stateFavourite == ResultState.Loading) {
            return Icon(Icons.favorite_outline);
          } else if (provider.stateFavourite == ResultState.NoData) {
            return IconButton(
              icon: Icon(Icons.favorite_outline, color: Colors.black87),
              onPressed: () {
                provider.toggleFavorite(restaurant).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved to favorite")));
                });
              },
            );
          } else if (provider.stateFavourite == ResultState.HasData) {
            return provider.favoriteRestaurants!
                    .where((element) => element.id == restaurant.id)
                    .isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Removed from favorite")));
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.favorite_outline, color: Colors.black87),
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Saved to favorite")));
                      });
                    },
                  );
          } else if (provider.stateFavourite == ResultState.Error) {
            return Icon(Icons.favorite_outline, color: Colors.black87);
          }
          return Container();
        }),
      
    );
  }
}