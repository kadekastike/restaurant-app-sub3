import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key, required this.restaurantElement});

  static const routeName = '/restaurant-detail';

  final RestaurantElement restaurantElement;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      var provider = RestaurantDetailProvider();
      return provider.getRestaurantDetail(restaurantElement.id);
    }, child: Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: state.restaurantDetail.restaurant.id,
                        child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${state.restaurantDetail.restaurant.pictureId}',
                            errorBuilder: (ctx, error, _) => const Image(
                                image: AssetImage('images/logo.jpg'))),
                      ),
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(children: [
                            Text(
                              state.restaurantDetail.restaurant.name,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ]),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                state.restaurantDetail.restaurant.city,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_outline_rounded,
                                color: Colors.orangeAccent,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                state.restaurantDetail.restaurant.rating
                                    .toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            state.restaurantDetail.restaurant.description,
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Menus',
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Foods',
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.08),
                          width: (MediaQuery.of(context).size.width * 0.94),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state
                                  .restaurantDetail.restaurant.menus.foods
                                  .map((foods) {
                                return Row(children: [
                                  _buildChipForMenu(foods.name),
                                  const SizedBox(width: 5)
                                ]);
                              }).toList()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Drinks',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.08),
                          width: (MediaQuery.of(context).size.width * 0.92),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.restaurantDetail.restaurant
                                  .menus.drinks
                                  .map((drinks) {
                                return Row(children: [
                                  _buildChipForMenu(drinks.name),
                                  const SizedBox(width: 5)
                                ]);
                              }).toList()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state.state == ResultState.noData) {
            return const Center(
            child: Material(
              child: Text("Terjadi Kesalahan, Data Tidak dapat dimuat"),
            ),
          );
          } else if (state.state == ResultState.error) {
            return const Center(
            child: Material(
              child: Text("Terjadi Kesalahan, Periksa Koneksi Internet Anda dan Coba Lagi"),
            ),
          );
          } else {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
        },
      ),
    ));
  }
}

Widget _buildChipForMenu(String label) {
  return Chip(
    labelPadding: const EdgeInsets.all(3.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.grey,
    elevation: 5.0,
    shadowColor: Colors.grey,
    padding: const EdgeInsets.all(8.0),
  );
}
