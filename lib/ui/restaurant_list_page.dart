import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/view_model/restaurant_list_view_model.dart';
import 'package:restaurant_app/utils/notif_helper.dart';
import 'package:restaurant_app/widgets/custom_appbar.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/resto_list';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // final NotificationHelper _notificationHelper = NotificationHelper();

  // @override
  // void initState() {
  //   super.initState();
  //   _notificationHelper
  //       .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  // }

  // @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Consumer<AppProvider>(
            builder: (context, provider, _) {
              return SliverPersistentHeader(
                delegate:
                    CustomSliverAppBar(expandedHeight: 250, provider: provider),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          Consumer<ZRestaurantListViewModel>(
            builder: (context, viewModel, _) {
              final state = viewModel.state;
              if (state.isLoading) {
                return SliverFillRemaining(
                  child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange))),
                );
              } else if (state.restaurants != null) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final restaurant = state.restaurants![index];
                      return RestaurantItem(
                        restaurant: restaurant,
                        provider:
                            Provider.of<AppProvider>(context, listen: false),
                      );
                    },
                    childCount: state.restaurants!.length,
                  ),
                );
              } else if (state.error != null) {
                print("Ada Error: ${state.error}");
                return SliverFillRemaining(
                  child: Center(
                    child: Lottie.asset('assets/lottie/no_internet.json'),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(
                      child: Lottie.asset('assets/lottie/search_empty.json')),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
