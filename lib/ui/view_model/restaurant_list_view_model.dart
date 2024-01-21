import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/domain/use_case/use_cases_restaurant.dart';
import 'package:restaurant_app/ui/state/restaurant_list_state.dart';

class ZRestaurantListViewModel with ChangeNotifier {
  final UseCasesRestaurant useCases;

  RestaurantListState _state = RestaurantListState();
  RestaurantListState get state => _state;

  ZRestaurantListViewModel(this.useCases) {
    getAllRestaurants();
  }

  Future<void> getAllRestaurants() async {
    _updateState(isLoading: true);

    try {
      final result = await useCases.getAllRestaurant();
      if (result.isSuccess) {
        _updateState(isLoading: false, restaurants: result.resultData);
      } else {
        _updateState(isLoading: false, error: result.errorMessage);
      }
    } catch (e) {
      _updateState(isLoading: false, error: e.toString());
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    List<Restaurant>? restaurants,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      restaurants: restaurants,
    );
    notifyListeners();
  }
}
