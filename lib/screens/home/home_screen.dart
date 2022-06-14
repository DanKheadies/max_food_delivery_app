import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:max_food_delivery_app/config/theme.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SvgPicture.asset(
          'assets/logo.svg',
          height: 100,
        ),
        // child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     primary: Theme.of(context).primaryColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/location');
        //   },
        //   child: Text(
        //     'Location Screen',
        //     style: Theme.of(context).textTheme.headline3!.copyWith(
        //           color: Colors.white,
        //         ),
        //   ),
        // ),
      ),
    );
  }
}
