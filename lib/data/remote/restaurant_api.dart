import 'package:restaurant_app/core/data/remote/api_config.dart';
import 'package:restaurant_app/data/model/response/response_detail_restaurant.dart';
import 'package:restaurant_app/data/model/response/response_restaurant.dart';
import 'package:restaurant_app/data/model/response/response_review_restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';

class RestaurantApi {
  final ApiConfig apiConfig;

  RestaurantApi({required this.apiConfig});

  Future<ResponseRestaurant> getList() async {
    try {
      return apiConfig.getApiService<ResponseRestaurant>(
        'list',
        decoder: (json) => ResponseRestaurant.fromJson(json),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseRestaurant> search({String query = ""}) async {
    try {
      return apiConfig.getApiService<ResponseRestaurant>('search?q=$query', decoder: (json) => ResponseRestaurant.fromJson(json));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseRestaurantDetail> getDetail(String id) async {
    try {
      return apiConfig.getApiService<ResponseRestaurantDetail>('detail/$id', decoder: (json) => ResponseRestaurantDetail.fromJson(json));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseReview> postReview(Review review) async {
    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      };

      return await apiConfig.postApiService<ResponseReview>('review',
          headers: headers, body: review.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
