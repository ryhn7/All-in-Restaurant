
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/response/response_detail_restaurant.dart';
import 'package:restaurant_app/data/model/response/response_restaurant.dart';
import 'package:restaurant_app/data/model/response/response_review_restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/utils/config.dart';
import 'package:restaurant_app/utils/const_string.dart';


class ApiService {
  Future<ResponseRestaurant> getList() async {
    try {
      final response = await http.get(Uri.parse(Configuration.Base_Url + 'list'));
      if (response.statusCode == 200) {
        // print(response.body);
        return ResponseRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(ConstString.failed_get_data);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error');
    }
  }

  Future<ResponseRestaurant> search({String query = ""}) async {
    try {
      final response =
          await http.get(Uri.parse(Configuration.Base_Url + 'search?q=' + query));
      if (response.statusCode == 200) {
        return ResponseRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(ConstString.failed_get_data);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error');
    }
  }

  Future<ResponseRestaurantDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse(Configuration.Base_Url + 'detail/$id'));
    if (response.statusCode == 200) {
      return ResponseRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(ConstString.failed_get_data);
    }
  }

  Future<ResponseReview> postReview(Review review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(Configuration.Base_Url + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ResponseReview.fromJson(json.decode(response.body));
    } else {
      throw Exception(ConstString.failed_post_review);
    }
  }
}