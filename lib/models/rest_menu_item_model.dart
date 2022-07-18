import 'package:equatable/equatable.dart';

class RestMenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String category;
  final String description;
  final double price;

  const RestMenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        name,
        category,
        description,
        price,
      ];

  static List<RestMenuItem> menuItems = const [
    RestMenuItem(
      id: 1,
      restaurantId: 1,
      name: 'Margherita',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    RestMenuItem(
      id: 2,
      restaurantId: 1,
      name: '4 Formaggi',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    RestMenuItem(
      id: 3,
      restaurantId: 1,
      name: 'Baviera',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    RestMenuItem(
      id: 4,
      restaurantId: 1,
      name: 'Savory, Spicy, Sweet',
      category: 'Pizza',
      description: 'Sausage, jalapeno, pineapple',
      price: 4.99,
    ),
    RestMenuItem(
      id: 5,
      restaurantId: 1,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    RestMenuItem(
      id: 6,
      restaurantId: 1,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    RestMenuItem(
      id: 7,
      restaurantId: 2,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    RestMenuItem(
      id: 8,
      restaurantId: 3,
      name: 'Water',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    RestMenuItem(
      id: 9,
      restaurantId: 2,
      name: 'Caesar Salad',
      category: 'Salad',
      description: 'A fresh drink',
      price: 1.99,
    ),
    RestMenuItem(
      id: 10,
      restaurantId: 3,
      name: 'CheeseBurger',
      category: 'Burger',
      description: 'A burger with Cheese',
      price: 9.99,
    ),
    RestMenuItem(
      id: 11,
      restaurantId: 4,
      name: 'Chocolate Cake',
      category: 'Dessert',
      description: 'A cake with chocolate',
      price: 9.99,
    )
  ];
}
