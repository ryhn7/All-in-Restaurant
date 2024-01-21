import 'package:restaurant_app/core/common/result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';

class TGetRestaurantById {
  final RestaurantRepository _repository;

  TGetRestaurantById(this._repository);

  Future<ResultState<Restaurant>> call(String id) async {
    return await _repository.getRestaurantById(id);
  }
}
