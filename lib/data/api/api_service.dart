import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return RestaurantSearch.fromJson(json.decode(response.body));
      
    } else {
      throw Exception("Failded to search restaurant");
    }
  }
}