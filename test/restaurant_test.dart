import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';


import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/model/response/response_detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/config.dart';


class MockClient extends Mock implements http.Client {}

void main() {
  group('Restaurant Test', () {
    late Restaurant restaurant;
    late http.Client client;

    setUp(() {
      client = MockClient();
      restaurant = Restaurant(
        id: "abc123",
        name: "Melting Pot",
        description: "Test 123",
        pictureId: "1",
        city: "Jakarta",
        rating: 4.7,
        address: '',
        categories: null,
        customerReviews: null,
        menus: null,
      );
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());

      expect(result.name, restaurant.name);
    });

    test("Should return restaurant detail from API", () async {
      when(() => client
              .get(Uri.parse(Configuration.Base_Url + 'detail/${restaurant.id}')))
          .thenAnswer((_) async {
        return http.Response(
            '''{
    "error": false,
    "message": "success",
    "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
            {
                "name": "Italia"
            },
            {
                "name": "Modern"
            }
        ],
        "menus": {
            "foods": [
                {
                    "name": "Paket rosemary"
                },
                {
                    "name": "Toastie salmon"
                }
            ],
            "drinks": [
                {
                    "name": "Es krim"
                },
                {
                    "name": "Sirup"
                }
            ]
        },
        "rating": 4.2,
        "customerReviews": [
            {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
            }
        ]
    }
}''',
            200);
      });
      var respond = await client
          .get(Uri.parse(Configuration.Base_Url + 'detail/${restaurant.id}'));
      ResponseRestaurantDetail resto = ResponseRestaurantDetail.fromJson(jsonDecode(respond.body));
      expect(resto.restaurant.name, restaurant.name);
    });


  });
}
