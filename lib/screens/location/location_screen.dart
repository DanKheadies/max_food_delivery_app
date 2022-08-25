import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/screens/screens.dart';
import 'package:max_food_delivery_app/widgets/widgets.dart';

class LocationScreen extends StatefulWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LocationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LocationLoaded) {
            Set<Marker> markers = state.restaurants!.map(
              (restaurant) {
                return Marker(
                    markerId: MarkerId(restaurant.id),
                    infoWindow: InfoWindow(
                        title: restaurant.name,
                        snippet: restaurant.description,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RestaurantDetailsScreen.routeName,
                            arguments: restaurant,
                          );
                        }),
                    position: LatLng(
                      restaurant.address.lat,
                      restaurant.address.long,
                    ));
              },
            ).toSet();
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  buildingsEnabled: false,
                  markers: markers,
                  onMapCreated: (GoogleMapController controller) {
                    context.read<LocationBloc>().add(
                          LoadMap(
                            controller: controller,
                          ),
                        );
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.place.lat,
                      state.place.long,
                    ),
                    zoom: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: 50,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(child: LocationSearchBox()),
                        ],
                      ),
                      const SearchBoxSuggestions(),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          fixedSize: const Size(200, 40),
                        ),
                        child: const Text('Save'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
