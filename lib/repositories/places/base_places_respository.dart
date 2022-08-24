import 'package:max_food_delivery_app/models/models.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutoComplete>?> getAutoComplete(String searchInput);
  Future<Place?> getPlace(String placeId);
}
