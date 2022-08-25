import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final FirebaseFirestore _firebaseFirestore;

  RestaurantRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Restaurant>> getRestaurants() {
    return _firebaseFirestore
        .collection('restaurants')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Restaurant>> getNearbyRestaurants(
    Place selectedAddress,
  ) {
    Stream<List<Restaurant>> restaurants = getRestaurants();
    int maxDistance = 10;

    return restaurants.map(
      (restaurants) {
        return restaurants
            .where(
              (restaurant) =>
                  _getRestaurantDistance(
                    restaurant.address,
                    selectedAddress,
                  ) <=
                  maxDistance,
            )
            .toList();
      },
    );
  }

  int _getRestaurantDistance(
    Place restaurantAddress,
    Place selectedAddress,
  ) {
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

    var distanceInKm = geolocator.distanceBetween(
          restaurantAddress.lat.toDouble(),
          restaurantAddress.long.toDouble(),
          selectedAddress.lat.toDouble(),
          selectedAddress.long.toDouble(),
        ) ~/
        1000;

    return distanceInKm;
  }
}
