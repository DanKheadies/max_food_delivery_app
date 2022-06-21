import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        name,
        description,
        price,
      ];

  static List<MenuItem> menuItems = const [
    MenuItem(
      id: 1,
      restaurantId: 1,
      name: 'Pizza',
      description: 'Pizza with sausage',
      price: 3.99,
    ),
    MenuItem(
      id: 2,
      restaurantId: 1,
      name: 'Coca Cola',
      description: 'A cold beverage',
      price: 1.99,
    ),
  ];
}
