import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/widgets/widgets.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  static const String routeName = '/restaurant-details';

  static Route route({
    required Restaurant restaurant,
  }) {
    return MaterialPageRoute(
      builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
      settings: const RouteSettings(name: routeName),
    );
  }

  final Restaurant restaurant;

  const RestaurantDetailsScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  Widget _buildMenuItems(
    Restaurant restaurant,
    BuildContext context,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            restaurant.tags[index],
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        Column(
          children: restaurant.menuItems
              .where((menuItem) => menuItem.category == restaurant.tags[index])
              .map(
                (menuItem) => Column(
                  children: [
                    Container(
                      // color: Colors.grey[100],
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          menuItem.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          menuItem.description,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${menuItem.price}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            BlocBuilder<BasketBloc, BasketState>(
                              builder: (context, state) {
                                if (state is BasketLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is BasketLoaded) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<BasketBloc>()
                                          .add(AddItem(menuItem));
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('Something went wrong.'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 2,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/basket');
                },
                child: const Text('Basket'),
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    restaurant.imageUrl,
                  ),
                ),
              ),
            ),
            RestaurantInformation(
              restaurant: restaurant,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurant.tags.length,
              itemBuilder: (context, index) {
                return _buildMenuItems(
                  restaurant,
                  context,
                  index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
