import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:restaurant_app/screen/setting_screen.dart';
import '../common/result_state.dart';
import '../widgets/restaurant_card.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  static const routeName = '/restaurant-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(value: 0, child: Text('Favorite')),
                const PopupMenuItem<int>(value: 1, child: Text('Setting')),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              } else if (value == 1) {
                Navigator.pushNamed(context, SettingScreen.routeName);
              }
            },
          )
        ],
      ),
      body: Consumer<RestaurantProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.restaurant.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.restaurant.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              });
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Material(
              child: Text("Terjadi Kesalahan. Data Tidak dapat dimuat."),
            ),
          );
        } else if (state.state == ResultState.error) {
          return const Center(
            child: Material(
              child: Text(
                  "Terjadi Kesalahan, Periksa Koneksi Internet Anda dan Coba Lagi"),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('Data Kosong'),
            ),
          );
        }
      }),
    );
  }
}
