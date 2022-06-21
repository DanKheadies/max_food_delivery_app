import 'dart:convert' as convert;
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;

import 'package:max_food_delivery_app/env/secrets.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/places/base_places_respository.dart';

class PlacesRepository extends BasePlacesRepository {
  String key = 'TBD';
  final String types = 'geocode';

  String checkPlatform() {
    if (Platform.isAndroid) {
      return googleMapsAndroidKey;
    } else if (Platform.isIOS) {
      return googleMapsiOSKey;
    }
    return key;
  }

  @override
  Future<List<PlaceAutoComplete>> getAutoComplete(String searchInput) async {
    key = checkPlatform();

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['predictions'] as List;

    return results.map((place) => PlaceAutoComplete.fromJson(place)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    key = checkPlatform();

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['results'] as Map<String, dynamic>;

    return Place.fromJson(results);
  }
}
