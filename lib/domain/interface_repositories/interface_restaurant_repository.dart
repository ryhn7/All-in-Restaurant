import 'package:restaurant_app/data/model/restaurant.dart';

import '../../core/common/result_state.dart';

abstract interface class IRestaurantRepository {
  Future<ResultState<List<Restaurant>>> getAllRestaurant();
  Future<ResultState<Restaurant>> getRestaurantById(String id);
}
