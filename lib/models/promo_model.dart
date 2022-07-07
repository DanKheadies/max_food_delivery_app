import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
      ];

  static List<Promo> promos = const [
    Promo(
      id: 1,
      title: 'FREE Delivery on Your First 3 Orders.',
      description:
          'Place an order of \$10 or more and the delivery fee is on us',
      imageUrl:
          'https://holisticgaming.com/static/media/party.8f569c57b20d0b839c7b.jpg',
    ),
    Promo(
      id: 2,
      title: '20% off on Selected Restaurants.',
      description: 'Get a discount at more than 200+ restaurants',
      imageUrl:
          'https://holisticgaming.com/static/media/phogs.e943b1787aa678db4324.jpg',
    ),
  ];
}
