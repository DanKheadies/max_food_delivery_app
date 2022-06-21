import 'package:equatable/equatable.dart';

import 'package:max_food_delivery_app/models/models.dart';

class Restaurant extends Equatable {
  final int id;
  final String imageUrl;
  final String name;
  final List<String> tags;
  final List<MenuItem> menuItems;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;

  const Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tags,
    required this.menuItems,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        tags,
        deliveryTime,
        deliveryFee,
        distance,
      ];

  static List<Restaurant> restaurants = [
    Restaurant(
      id: 1,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/tsodk.8f8ceb07491dae3e6199.png',
      tags: const ['Italian', 'Dessert', 'Ice Cream'],
      menuItems: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 1)
          .toList(),
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 2,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/toel.adf11c386b0caeebcc0e.png',
      tags: const ['Italian', 'Dessert', 'Ice Cream'],
      menuItems: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 2)
          .toList(),
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 3,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/td_sbf_td.8e0469aa0058ebe357fb.png',
      tags: const ['Italian', 'Dessert', 'Ice Cream'],
      menuItems: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 3)
          .toList(),
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 4,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://holisticgaming.com/static/media/immunis.f0bd6337e26699fa3b49.png',
      tags: const ['Italian', 'Dessert', 'Ice Cream'],
      menuItems: MenuItem.menuItems
          .where((menuItem) => menuItem.restaurantId == 4)
          .toList(),
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
  ];
}
