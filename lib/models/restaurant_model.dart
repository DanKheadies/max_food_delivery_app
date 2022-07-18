import 'package:equatable/equatable.dart';

import 'package:max_food_delivery_app/models/models.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> tags;
  final List<RestMenuItem> menuItems;
  final String priceCategory;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.menuItems,
    required this.priceCategory,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        tags,
        menuItems,
        priceCategory,
        deliveryTime,
        deliveryFee,
        distance,
      ];

  static List<Restaurant> restaurants = [
    Restaurant(
      id: 1,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/terraria.3233a77fadd0c6f979f3.jpg',
      tags: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 1)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 1)
          .toList(),
      priceCategory: '\$',
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 2,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/toel.adf11c386b0caeebcc0e.png',
      tags: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 2)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 2)
          .toList(),
      priceCategory: '\$',
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 3,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/td_sbf_td.8e0469aa0058ebe357fb.png',
      tags: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 3)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 3)
          .toList(),
      priceCategory: '\$',
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 4,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/immunis.f0bd6337e26699fa3b49.png',
      tags: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 4)
          .map((menuItem) => menuItem.category)
          .toSet()
          .toList(),
      menuItems: RestMenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 4)
          .toList(),
      priceCategory: '\$\$',
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
  ];
}
