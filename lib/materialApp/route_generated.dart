import 'package:flutter/material.dart';

import 'custom_navigator_observer.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final CustomNavigatorObserver _customNavigatorObserver =
      CustomNavigatorObserver();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Generate Initial Routes Demo',
      initialRoute: '/second/42',
      onGenerateInitialRoutes:
          _onGenerateInitialRoutes,
      navigatorObservers: [
        _customNavigatorObserver, // Add the CustomNavigatorObserver to the navigatorObservers list
      ],
      onUnknownRoute: _onUnknownRoute, // Assign the _onGenerateInitialRoutes function to MaterialApp
    );
  }

  List<Route<dynamic>> _onGenerateInitialRoutes(String initialRoute) {
    final uri = Uri.parse(initialRoute);
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'second') {
      final id = int.tryParse(uri.pathSegments.last);
      if (id != null) {
        return [
          MaterialPageRoute(builder: (context) => const HomePage()),
          MaterialPageRoute(builder: (context) => SecondPage(id: id)),
        ];
      }
    }
    return [MaterialPageRoute(builder: (context) => const HomePage())];
  }
  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => NotFoundPage(routeName: settings.name!),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Home Page')),
      body:const Center(child: Text('Home Page')),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int id;

  const SecondPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(child: Text('Second Page with ID: $id')),
    );
  }
}
class NotFoundPage extends StatelessWidget {
  final String routeName;

  const NotFoundPage({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: Center(
        child: Text('Route "$routeName" not found.'),
      ),
    );
  }
}

