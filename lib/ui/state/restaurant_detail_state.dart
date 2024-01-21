import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailListState {
  final bool isLoading;
  final String? error;

  final Restaurant? restaurant;

  RestaurantDetailListState({
    this.isLoading = false,
    this.error,
    this.restaurant,
  });

  RestaurantDetailListState copyWith({
    bool? isLoading,
    String? error,
    Restaurant? restaurant,
  }) {
    return RestaurantDetailListState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      restaurant: restaurant ?? this.restaurant,
    );
  }
}

