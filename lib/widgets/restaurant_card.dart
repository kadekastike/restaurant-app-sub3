import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/helper/navigation.dart';

import '../screen/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantElement restaurant;

  RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
      return Card(
    child: InkWell(
        splashColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
            leading: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 80,
                minHeight: 80,
                maxWidth: 80,
                maxHeight: 80,
              ),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, _) =>
                    const Image(image: AssetImage('images/logo.jpg')),
              ),
            ),
            title: Text(restaurant.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline_rounded,
                      color: Colors.orangeAccent,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigation.intentWithData(RestaurantDetailScreen.routeName, restaurant);
        }),
  );
  }
}