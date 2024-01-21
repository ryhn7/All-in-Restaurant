import 'package:injectable/injectable.dart';
import 'package:restaurant_app/core/data/remote/api_config.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/di/injection.dart';
import 'package:restaurant_app/domain/use_case/get_all_restaurant.dart';
import 'package:restaurant_app/domain/use_case/get_restaurant_by_id.dart';
import 'package:restaurant_app/domain/use_case/use_cases_restaurant.dart';
import 'package:restaurant_app/ui/view_model/restaurant_detail_view_model.dart';
import 'package:restaurant_app/ui/view_model/restaurant_list_view_model.dart';

@module
abstract class AllInModule {
  @singleton
  ApiConfig get apiConfig => ApiConfig();

  @injectable
  RestaurantApi get restaurantApi => RestaurantApi(apiConfig: getIt());

  @singleton
  RestaurantRepository get restaurantRepository =>
      RestaurantRepository(getIt());

  @singleton
  SGetAllRestaurant get getAllRestaurant => SGetAllRestaurant(getIt());

  @singleton
  TGetRestaurantById get getRestaurantById => TGetRestaurantById(getIt());

  @singleton
  UseCasesRestaurant get useCasesRestaurant => UseCasesRestaurant(
        getAllRestaurant: getIt(),
        getRestaurantById: getIt(),
      );

  @singleton
  ZRestaurantListViewModel get restaurantListViewModel =>
      ZRestaurantListViewModel(getIt());

  @singleton
  ZRestaurantDetailViewModel get restaurantDetailViewModel =>
      ZRestaurantDetailViewModel(getIt());
}
