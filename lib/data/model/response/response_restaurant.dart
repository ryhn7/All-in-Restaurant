import 'package:restaurant_app/data/model/restaurant.dart';

class ResponseRestaurant {
  ResponseRestaurant(
      {required this.error, required this.message, required this.count, required this.restaurants});

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory ResponseRestaurant.fromJson(Map<String, dynamic> json) => ResponseRestaurant(
      error: json['error'],
      message: json['message'] ?? "",
      count: json['count'] ?? 0,
      restaurants: List<Restaurant>.from(json['restaurants'].map((x) => Restaurant.fromJson(x))));
}