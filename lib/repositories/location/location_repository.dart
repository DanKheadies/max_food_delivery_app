import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:max_food_delivery_app/datasources/datasources.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

class LocationRepository extends BaseLocationRepository {
  final LocalDatasource localDatasource;
  final PlacesAPI placesAPI;

  LocationRepository({
    required this.localDatasource,
    required this.placesAPI,
  });

  @override
  Future<List<Place>> getAutoComplete(String searchInput) {
    return placesAPI.getAutoComplete(searchInput);
  }

  @override
  Future<Place?> getPlace([String? placeId]) async {
    if (placeId == null) {
      Box box = await localDatasource.openBox('user_location');
      Place? place = localDatasource.getPlace(box);
      return place;
    } else {
      final Place place = await placesAPI.getPlace(placeId);
      Box box = await localDatasource.openBox('user_location');

      localDatasource.clearBox(box);
      localDatasource.addPlace(box, place);

      return place;
    }
  }
}
