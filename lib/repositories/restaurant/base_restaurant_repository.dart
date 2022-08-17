import 'package:max_food_delivery_app/models/models.dart';

abstract class BaseRestaurantRepository {
  Stream<List<Restaurant>> getRestaurant();
}
