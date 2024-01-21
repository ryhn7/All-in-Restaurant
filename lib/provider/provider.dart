import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api.service.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/response/response_detail_restaurant.dart';
import 'package:restaurant_app/data/model/response/response_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/domain/use_case/use_cases_restaurant.dart';
import 'package:restaurant_app/ui/state/restaurant_detail_state.dart';

enum ResultState { Loading, NoData, HasData, Error }

class AppProvider extends ChangeNotifier {
  final RestaurantApi apiService;
  final UseCasesRestaurant useCases;
  final DbService dbService = DbService();

  AppProvider({required this.apiService, required this.useCases});

  ResponseRestaurant? _responseRestaurant;
  ResponseRestaurantDetail? _responseRestaurantDetail;
  List<Restaurant>? _favoriteRestaurant;
  ResultState? _state;
  ResultState? _stateDetail;
  ResultState? _stateFavourite;
  String _message = "";
  String _query = "";

  ResponseRestaurant? get result => _responseRestaurant;
  ResponseRestaurantDetail? get restaurant => _responseRestaurantDetail;
  List<Restaurant>? get favoriteRestaurants => _favoriteRestaurant;
  ResultState? get state => _state;
  ResultState? get stateDetail => _stateDetail;
  ResultState? get stateFavourite => _stateFavourite;
  String get message => _message;

  RestaurantDetailListState _stateDetailResto = RestaurantDetailListState();
  RestaurantDetailListState get stateDetailResto => _stateDetailResto;

  void getRestaurants() {
    _fetchRestaurants();
  }

  // Future<void> getRestaurant(String id) async {
  //   await _fetchRestaurant(id);
  // }

  Future<void> getRestaurantById(String id) async {
    _updateState(isLoading: true);

    try {
      final result = await useCases.getRestaurantById(id);
      if (result.isSuccess) {
        _updateState(isLoading: false, restaurant: result.resultData);
      } else {
        _updateState(isLoading: false, error: result.errorMessage);
      }
    } catch (e) {
      _updateState(isLoading: false, error: e.toString());
    }
  }

  Future<void> getFavoriteRestaurants() async {
    await _getFavorites();
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      print(e.toString());
      return _message = 'Error';
    }
  }

  Future<dynamic> _searchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.search(query: _query);
      print(response);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      print(e.toString());
      return _message = 'Error';
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _stateDetail = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _stateDetail = ResultState.HasData;
        notifyListeners();
        return _responseRestaurantDetail = response;
      } else {
        _stateDetail = ResultState.NoData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _stateDetail = ResultState.Error;
      notifyListeners();
      print(e.toString());
      return _message = 'Error --> $e';
    }
  }

  void onSearch(String query) {
    _query = query;
    _searchRestaurant();
  }

  Future<dynamic> postReview(Review review) async {
    try {
      final response = await apiService.postReview(review);

      if (!response.error) _fetchRestaurant(review.id);
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _getFavorites() async {
    try {
      _stateFavourite = ResultState.Loading;
      notifyListeners();
      final response = await dbService.getFavorites();
      if (response.isNotEmpty) {
        _stateFavourite = ResultState.HasData;
        notifyListeners();
        return _favoriteRestaurant = response;
      } else {
        _stateFavourite = ResultState.NoData;
        notifyListeners();
        return _message = "No favorite restaurants yet";
      }
    } catch (e) {
      _stateFavourite = ResultState.Error;
      notifyListeners();
      return _message = 'Error';
    }
  }

  Future<dynamic> toggleFavorite(Restaurant restaurant) async {
    try {
      _stateFavourite = ResultState.Loading;
      notifyListeners();
      final response = await dbService.toggleFavorite(restaurant);
      if (response.isNotEmpty) {
        _stateFavourite = ResultState.HasData;
        notifyListeners();
        return _favoriteRestaurant = response;
      } else {
        _stateFavourite = ResultState.NoData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _stateFavourite = ResultState.Error;
      notifyListeners();
      return _message = 'Error';
    }
  }

  void _updateState({
    bool? isLoading,
    String? error,
    Restaurant? restaurant,
  }) {
    _stateDetailResto = _stateDetailResto.copyWith(
      isLoading: isLoading,
      error: error,
      restaurant: restaurant,
    );
    notifyListeners();
  }
}
