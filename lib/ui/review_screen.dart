import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/ui/review_button.dart';

class ReviewScreen extends StatelessWidget {
  final Restaurant restaurant;

  const ReviewScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    late AppProvider _provider;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reviews",
          style: TextStyle(fontFamily: "HellixBold"),
        ),
      ),
      body: Container(
        child: Consumer<AppProvider>(builder: (context, provider, _) {
          _provider = provider;
          if (provider.state == ResultState.Loading) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)));
          } else if (provider.state == ResultState.NoData) {
            return Center(child: Text(provider.message));
          } else if (provider.state == ResultState.HasData) {
            Restaurant _restaurant = provider.restaurant!.restaurant;
            return ListView.builder(
                itemCount: _restaurant.customerReviews!.length,
                itemBuilder: (context, index) {
                  Review review = _restaurant.customerReviews![index];
                  return item(review);
                });
          } else if (provider.state == ResultState.Error) {
            return Center(
              child: Lottie.asset('assets/lottie/no_internet.json'),
            );
          }
          return Container();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                ReviewDialog(provider: _provider, id: restaurant.id),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }

  Widget item(Review review) {
    return Card(
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(
                  review.name[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        review.date,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        review.review,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
