import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/menus.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/utils/utils.dart';
import 'package:restaurant_app/widgets/detail_appbar.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, state, _) {
          if (state.stateDetail == ResultState.Loading) {
            return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)
            ));
          } else if (state.stateDetail == ResultState.HasData) {
            final provider = Provider.of<AppProvider>(context, listen: false);
            return screen(context, state.restaurant!.restaurant, provider);
          } else if (state.stateDetail == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.stateDetail == ResultState.Error) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Lottie.asset('assets/lottie/no_internet.json'),
              ),
            );
          } else {
            return Center(
              child: Text('No data to displayed'),
            );
          }
        },
      ),
    );
  }

  screen(BuildContext context, Restaurant restaurant, AppProvider provider) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: DetailAppBar(
              expandedHeight: 450, restaurant: restaurant, provider: provider),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 10.0,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Foods',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "HellixBold",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            
          )),
        ),
        menuList(restaurant.menus!.foods, MenuType.food),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 10.0,
              ),
              SizedBox(
                height: 70.0,
              ),
              Text(
                'Drinks',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "HellixBold",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          )),
        ),
        menuList(restaurant.menus!.drinks, MenuType.drink),
      ],
    );
  }

  menuList(List<dynamic> menus, MenuType menuType) {
    return SliverPadding(
      padding: EdgeInsets.all(4.0),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: menus.map((e) {
          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: kLightColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          alignment: FractionalOffset.center,
                          image: (menuType == MenuType.food)
                              ? AssetImage('images/photo/food.png')
                              : AssetImage('images/photo/drink.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Utils.camelCase(e.name) ?? "Empty Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
