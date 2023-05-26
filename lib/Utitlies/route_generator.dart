import 'package:flutter/material.dart';

import '../Screens/nfts_screen.dart';
// import 'package:routing_prep/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
      return MaterialPageRoute(builder: (_) => const NFTsScreen(),);
      case '/second':
        // if (args is String) {
        //   return MaterialPageRoute(
        //     builder: (_) => SecondPage(
        //       data: args,
        //     ),
        //   );
        // }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
