import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/search-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<SearchRestaurantProvider>(context, listen: false)
                    .searchRestaurant(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            const Text(
              'Search Result',
            ),
            Consumer<SearchRestaurantProvider>(
              builder: (context, state, child) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.state == ResultState.hasData) {
                  final result = state.restaurant;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final restaurant = result.restaurants[index];
                        return RestaurantCard(restaurant: restaurant);
                      },
                      itemCount: result.restaurants.length,
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return const Center(
                    child: Material(
                      child: Text("Terjadi Kesalahan, Data Tidak dapat dimuat"),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return const Text(
                      "Terjadi Kesalahan, Silakan Periksa Koneksi Internet anda dan coba lagi");
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}