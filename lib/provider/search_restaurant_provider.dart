import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import '../common/result_state.dart';
import '../data/api/api_service.dart';

class SearchRestaurantProvider extends ChangeNotifier {
    final ApiService apiService = ApiService();

  SearchRestaurantProvider searchRestaurant(String query) {
    _fetchSearchedRestaurant(query);
    return this;
  }

  late RestaurantSearch _restaurant;
  late ResultState _state = ResultState.input;
  String _message = '';

  String get message => _message;

  RestaurantSearch get restaurant => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchedRestaurant(String query) async {
  try {

  
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
    
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
  } catch (e) {
        _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
  }
    
  }
}