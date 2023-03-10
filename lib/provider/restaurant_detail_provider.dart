import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import '../common/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantDetailProvider getRestaurantDetail(String id) {
    _fetchRestaurantDetail(id);
    return this;
  }

  late RestaurantDetail _restaurantDetail;
  ResultState? _state;
  String _message = '';

  String get message => _message;
  
  RestaurantDetail get restaurantDetail => _restaurantDetail;

  ResultState? get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      if (!restaurantDetail.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}