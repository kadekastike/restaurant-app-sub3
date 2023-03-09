import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/screen/list_restaurant.dart';
import 'package:restaurant_app/screen/restaurant_detail.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:restaurant_app/screen/splash_screen.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child:  MaterialApp(
      title: 'Restaurant',
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantListScreen.routeName: (context) => const RestaurantListScreen(),
        SearchPage.routeName: (context) => const SearchPage(),
        RestaurantDetailScreen.routeName: (context) => 
          RestaurantDetailScreen(restaurantElement: 
            ModalRoute.of(context)?.settings.arguments as RestaurantElement)
      },
    ) ,
    );

  }
}
