import 'package:restaurant_app/core/common/result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';

class SGetAllRestaurant {
  final RestaurantRepository _repository;

  SGetAllRestaurant(this._repository);

  Future<ResultState<List<Restaurant>>> call() async {
    return await _repository.getAllRestaurant();
  }
}
