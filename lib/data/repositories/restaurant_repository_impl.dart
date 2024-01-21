import 'package:restaurant_app/core/common/result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/domain/interface_repositories/interface_restaurant_repository.dart';

class RestaurantRepository implements IRestaurantRepository {
  final RestaurantApi api;

  RestaurantRepository(this.api);

  @override
  Future<ResultState<List<Restaurant>>> getAllRestaurant() async {
    try {
      // await Future.delayed(Duration(seconds: 1));

      final response = await api.getList();

      return ResultState.success(response.restaurants);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<Restaurant>> getRestaurantById(String id) async {
    try {

      final response = await api.getDetail(id);

      return ResultState.success(response.restaurant);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
