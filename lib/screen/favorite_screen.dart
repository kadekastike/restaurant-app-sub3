import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import '../widgets/restaurant_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurant"),
      ),
      body: SafeArea(
          child: Consumer<DatabaseProvider>(builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var favoriteRestaurant = provider.favorites[index];
                return RestaurantCard(restaurant: favoriteRestaurant);
              });
        } else if (provider.state == ResultState.noData) {
          return const Center(
            child: Material(
              child: Text("Terjadi Kesalahan. Data Tidak dapat dimuat."),
            ),
          );
        } else if (provider.state == ResultState.error) {
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
      })),
    );
  }
}
