import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'place_model.g.dart';
// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Place extends Equatable {
  @HiveField(0)
  final String placeId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double long;

  const Place({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.long,
  });

  static const empty = Place(
    lat: 0,
    long: 0,
  );

  factory Place.fromJson(Map<String, dynamic> json) {
    if (!json.keys.contains('name')) {
      return Place(
        placeId: json['place_id'],
        name: json['description'],
        lat: 0,
        long: 0,
      );
    }
    if (json.keys.contains('place_id')) {
      return Place(
        placeId: json['place_id'],
        name: json['name'],
        lat: json['geometry']['location']['lat'],
        long: json['geometry']['location']['lng'],
      );
    } else {
      return Place(
        placeId: json['placeId'],
        name: json['name'],
        lat: json['lat'],
        long: json['long'],
      );
    }
  }

  @override
  List<Object?> get props => [
        placeId,
        name,
        lat,
        long,
      ];
}
