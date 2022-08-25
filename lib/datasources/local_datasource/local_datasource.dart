import 'package:hive/hive.dart';

import 'package:max_food_delivery_app/models/place_model.dart';

abstract class LocalDatasource {
  Future<Box> openBox(String boxName);
  Future<void> clearBox(Box box);

  Place? getPlace(Box box);
  Future<void> addPlace(Box box, Place place);

  /// More methods to store other types of data.
  /// ...
  ///
  ///
}

class LocalDatasourceImplementation extends LocalDatasource {
  String boxName = 'user-location';
  Type boxType = Place;

  @override
  Future<Box> openBox(String boxName) async {
    Box box = await Hive.openBox<Place>(boxName);
    return box;
  }

  @override
  Future<void> addPlace(Box box, Place place) async {
    await box.put(place.placeId, place);
  }

  @override
  Future<void> clearBox(Box box) async {
    await box.clear();
  }

  @override
  Place? getPlace(Box box) {
    if (box.values.isNotEmpty) {
      return box.values.first as Place;
    } else {
      return null;
    }
  }
}
