import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:max_food_delivery_app/models/models.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> tags;
  final List<Category> categories;
  final List<Product> products;
  final List<OpeningHours> openingHours;
  final String priceCategory;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;
  final Place address;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.tags,
    required this.categories,
    required this.products,
    required this.openingHours,
    this.priceCategory = '\$',
    this.deliveryTime = 10,
    this.deliveryFee = 10,
    this.distance = 15,
    required this.address,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        description,
        tags,
        categories,
        products,
        openingHours,
        priceCategory,
        deliveryTime,
        deliveryFee,
        distance,
        address,
      ];

  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      description: snap['description'],
      tags: (snap['tags'] as List).map((tag) {
        return tag as String;
      }).toList(),
      categories: (snap['categories'] as List).map((category) {
        return Category.fromSnapshot(category);
      }).toList(),
      // categories: Category.categories,
      products: (snap['products'] as List).map((product) {
        return Product.fromSnapshot(product);
      }).toList(),
      // products: Product.products,
      openingHours: (snap['openingHours'] as List).map((openingHour) {
        return OpeningHours.fromSnapshot(openingHour);
      }).toList(),
      // openingHours: OpeningHours.openingHoursList,
      address: Place.fromJson(snap['address']),
    );
  }

  static List<Restaurant> restaurants = [
    // Restaurant(
    //   id: 'HfcneOR3g8Jpfrpdaj92',
    //   name: 'Golden Ice Gelato Artigianale',
    //   imageUrl:
    //       'https://holisticgaming.com/static/media/terraria.3233a77fadd0c6f979f3.jpg',
    //   description: 'Great grub!',
    //   tags: Product.products
    //       .where((product) => product.restaurantId == 'HfcneOR3g8Jpfrpdaj92')
    //       .map((product) => product.category)
    //       .toSet()
    //       .toList(),
    //   categories: Category.categories,
    //   products: Product.products
    //       .where((product) => product.restaurantId == 'HfcneOR3g8Jpfrpdaj92')
    //       .toList(),
    //   openingHours: OpeningHours.openingHoursList,
    //   priceCategory: '\$',
    //   deliveryTime: 30,
    //   deliveryFee: 2.99,
    //   distance: 0.1,
    // ),
  ];
}
