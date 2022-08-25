import 'package:max_food_delivery_app/models/models.dart';

abstract class BaseLocationRepository {
  Future<List<Place>> getAutoComplete(String searchInput);
  Future<Place?> getPlace(String? placeId);
}
