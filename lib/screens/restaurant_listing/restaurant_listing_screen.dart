import 'package:flutter/material.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/widgets/widgets.dart';

class RestaurantListingScreen extends StatelessWidget {
  static const String routeName = '/restaurant-listing';

  static Route route({
    required List<Restaurant> restaurants,
  }) {
    return MaterialPageRoute(
      builder: (_) => RestaurantListingScreen(
        restaurants: restaurants,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final List<Restaurant> restaurants;

  const RestaurantListingScreen({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantCard(
              restaurant: restaurants[index],
            );
          },
        ),
      ),
    );
  }
}
