import 'package:restaurant_app/data/model/restaurant_list.dart';

class RestaurantSearch {
    RestaurantSearch({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<RestaurantElement> restaurants;

    factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantElement>.from(json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
    );

}