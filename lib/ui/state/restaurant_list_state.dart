import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantListState {
  final bool isLoading;
  final String? error;

  final List<Restaurant>? restaurants;

  RestaurantListState({
    this.isLoading = false,
    this.error,
    this.restaurants,
  });

  RestaurantListState copyWith({
    bool? isLoading,
    String? error,
    List<Restaurant>? restaurants,
  }) {
    return RestaurantListState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
