import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/domain/use_case/use_cases_restaurant.dart';
import 'package:restaurant_app/ui/state/restaurant_detail_state.dart';

class ZRestaurantDetailViewModel with ChangeNotifier {
  final UseCasesRestaurant useCases;
  final DbService dbService = DbService();

  RestaurantDetailListState _state = RestaurantDetailListState();
  RestaurantDetailListState get state => _state;

  ZRestaurantDetailViewModel(this.useCases);

  Future<void> getRestaurantById(String id) async {
    try {
      final result = await useCases.getRestaurantById(id);
      if (result.isLoading) {
        _updateState(isLoading: true);
      } else if (result.isSuccess) {
        _updateState(isLoading: false, restaurant: result.resultData);
      } else {
        _updateState(isLoading: false, error: result.errorMessage);
      }
    } catch (e) {
      _updateState(isLoading: false, error: e.toString());
    }
  }

  void toggleFavorite(Restaurant restaurant) async {
    try {
      final result = await dbService.getFavorites();
      if(result.isNotEmpty) {
        
      }
    } catch (e) {}
  }

  void _updateState({
    bool? isLoading,
    String? error,
    Restaurant? restaurant,
  }) {
    _state = _state.copyWith(
      isLoading: isLoading,
      error: error,
      restaurant: restaurant,
    );
    notifyListeners();
  }
}

