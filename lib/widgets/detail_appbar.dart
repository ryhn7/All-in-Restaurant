import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/ui/review_screen.dart';
import 'package:restaurant_app/widgets/favorite_button.dart';

class DetailAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Restaurant restaurant;
  final AppProvider provider;

  DetailAppBar(
      {required this.expandedHeight,
      required this.restaurant,
      required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: kOrangeColor,
                    image: DecorationImage(
                      image: NetworkImage(restaurant.getLargePict()),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: kOrangeColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kLightColor,
                            ),
                            child: Center(
                              child: FavoriteButton(
                                restaurant: restaurant,
                                provider: provider,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                  color: kLightColor,
                                  fontSize: 32.0,
                                  fontFamily: "HellixBold",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'images/icon/placeholder.png'),
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: kLightColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('images/icon/star.png'),
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${restaurant.rating}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kLightColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .getRestaurant(restaurant.id);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ReviewScreen(restaurant: restaurant);
                                  })).then((value) => setState(provider));
                                },
                                child: Text(
                                  " ${restaurant.customerReviews!.length} reviews",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: kLightColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 17.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 350.0,
                                    child: ReadMoreText(
                                      restaurant.description,
                                      trimLines: 1,
                                      colorClickableText: kOrangeColor,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: '..Show more',
                                      trimExpandedText: ' Show less',
                                      // maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: kLightColor,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  setState(AppProvider provider) {
    provider.getRestaurant(restaurant.id);
  }
}
