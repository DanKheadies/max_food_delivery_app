import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
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
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
            return Stack(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   width: double.infinity,
                //   child: BlocBuilder<GeolocationBloc, GeolocationState>(
                BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                    if (state is GeolocationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GeolocationLoaded) {
                      return Stack(
                        children: [
                          Gmap(
                            lat: state.position.latitude,
                            long: state.position.longitude,
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('Something went wrong.'),
                      );
                    }
                  },
                ),
                // ),
                const Location(),
                const SaveButton(),
              ],
            );
          } else if (state is PlaceLoaded) {
            return Stack(
              children: [
                Gmap(
                  lat: state.place.lat,
                  long: state.place.long,
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
