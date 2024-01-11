import 'dart:core';


import 'package:restaurant_app/data/model/categori.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_app/utils/config.dart';

import 'menus.dart';

part 'restaurant.g.dart';

@HiveType(typeId: 0)
class Restaurant {
  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.address,
      required this.categories,
      required this.menus,
      required this.customerReviews});

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String pictureId;
  @HiveField(4)
  String address;
  @HiveField(5)
  String city;
  @HiveField(6)
  double rating;
  @HiveField(7)
  List<Categories>? categories;
  @HiveField(8)
  Menus? menus;
  @HiveField(9)
  List<Review>? customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      pictureId: json["pictureId"],
      address: json["address"] == null ? "" : json["address"],
      city: json["city"] ?? "",
      rating: json["rating"].toDouble(),
      categories: json["categories"] == null
          ? null
          : List<Categories>.from(
              json['categories'].map((x) => Categories.fromJson(x))),
      menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
      customerReviews: json["customerReviews"] == null
          ? null
          : List<Review>.from((json["customerReviews"] as List)
              .map((x) => Review.fromJson(x))
              .where((review) => review.name.length > 0)));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "address": address,
        "city": city,
        "rating": rating,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((e) => e.toJson())),
        "menus": menus == null ? null : menus!.toJson(),
        "customerReviews": customerReviews == null
            ? null
            : List<dynamic>.from(customerReviews!.map((e) => e.toJson()))
      };

  String getSmallPict() => Configuration.Img_Small + this.pictureId;

  String getMediumPict() => Configuration.Img_Med + this.pictureId;

  String getLargePict() => Configuration.Img_Large + this.pictureId;
}
