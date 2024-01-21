import 'package:restaurant_app/domain/use_case/get_all_restaurant.dart';
import 'package:restaurant_app/domain/use_case/get_restaurant_by_id.dart';

class UseCasesRestaurant {
  final SGetAllRestaurant getAllRestaurant;
  final TGetRestaurantById getRestaurantById;

  UseCasesRestaurant({
    required this.getAllRestaurant,
    required this.getRestaurantById,
  });
}
