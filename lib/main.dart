import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/config/app_router.dart';
import 'package:max_food_delivery_app/config/theme.dart';
import 'package:max_food_delivery_app/firebase_options.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';
import 'package:max_food_delivery_app/screens/screens.dart';
import 'package:max_food_delivery_app/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<LocalStorageRepository>(
          create: (_) => LocalStorageRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
        RepositoryProvider<RestaurantRepository>(
          create: (_) => RestaurantRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AutoCompleteBloc(
              placesRepository: context.read<PlacesRepository>(),
            )..add(const LoadAutoComplete()),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              geolocationRepository: context.read<GeolocationRepository>(),
              localStorageRepository: context.read<LocalStorageRepository>(),
              placesRepository: context.read<PlacesRepository>(),
            )..add(const LoadMap()),
          ),
          // Order is important: RestaurantBloc has to initialize before Filter
          BlocProvider(
            create: (context) => RestaurantBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FilterBloc(
              restaurantBloc: context.read<RestaurantBloc>(),
            )..add(LoadFilter()),
          ),
          // Order is important: VoucherBloc has to initialize before Basket
          BlocProvider(
            create: (context) => VoucherBloc(
              voucherRepository: VoucherRepository(),
            )..add(LoadVouchers()),
          ),
          BlocProvider(
            create: (context) => BasketBloc(
              voucherBloc: BlocProvider.of<VoucherBloc>(context),
            )..add(StartBasket()),
          ),
        ],
        child: MaterialApp(
          title: 'Food Delivery',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: LocationScreen.routeName,
        ),
      ),
    );
  }
}
