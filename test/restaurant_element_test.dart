import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'retaurant_element_test_mocks.dart';

@GenerateMocks([RestaurantDetailProvider, ApiService])
void main() {
    late Restaurant restaurantElement;

    setUp(() {
      restaurantElement = Restaurant(
        id: "id123456",
        name: "Kadek's Coffee",
        description: "bestest coffee shop in the entire universe",
        pictureId: "aoid0",
        city: "wakanda",
        rating: 4.9, 
        address: 'mcu', 
        customerReviews: [
          CustomerReview(
            name: "Sam", 
            review: "Keren bangged", 
            date: "11 Maret 2023")
        ], 
        categories: [
          Category(name: "Coffe")
        ], 
        menus: Menus(
          foods: [Category(name: "pizza")], 
          drinks: [Category(name: "es teh")]),
      );
    });

    test('should success parsing json data', () {
      var result = RestaurantElement.fromJson(restaurantElement.toJson());
      expect(result.name, restaurantElement.name);
    });

}
