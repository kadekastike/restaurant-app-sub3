import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/helper/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({ required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantElement> _favorites = [];
  List<RestaurantElement> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultState.loading;
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Data Kosong';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantElement restaurantElement) async {
    try {
      await databaseHelper.insertFavorite(restaurantElement);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}