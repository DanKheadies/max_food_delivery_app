import 'package:flutter/material.dart';

class RestaurantListingScreen extends StatelessWidget {
  static const String routeName = '/restaurant-listing';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const RestaurantListingScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const RestaurantListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Listing'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Home Screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
