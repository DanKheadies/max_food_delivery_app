import 'dart:convert' as convert;
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;

import 'package:max_food_delivery_app/env/secrets.dart';
import 'package:max_food_delivery_app/models/models.dart';

abstract class PlacesAPI {
  Future<List<Place>> getAutoComplete(String searchInput);
  Future<Place> getPlace(String placeId);
}

class PlacesAPIImplementation extends PlacesAPI {
  String key = 'TBD';
  final String types = 'geocode';

  static const baseUrl = 'https://maps.googleapis.com/maps/api/place';

  String checkPlatform() {
    if (Platform.isAndroid) {
      return googleMapsAndroidKey;
    } else if (Platform.isIOS) {
      return googleMapsiOSKey;
    }
    return key;
  }

  @override
  Future<List<Place>> getAutoComplete(String searchInput) async {
    key = checkPlatform();

    final String url =
        '$baseUrl/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var results = json['predictions'] as List;

      return results.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Future<Place> getPlace(String placeId) async {
    key = checkPlatform();

    final String url = '$baseUrl/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var results = json['result'] as Map<String, dynamic>;

      return Place.fromJson(results);
    } else {
      throw Exception();
    }
  }
}
