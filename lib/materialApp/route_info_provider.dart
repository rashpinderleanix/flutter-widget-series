import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomRouteInformationProvider _customRouteInformationProvider =
      CustomRouteInformationProvider();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Route Information Provider Demo',
      routerDelegate: CustomRouterDelegate(),
      routeInformationParser: CustomRouteInformationParser(),
      routeInformationProvider:
          _customRouteInformationProvider, // Use the custom RouteInformationProvider
    );
  }
}

class CustomRouteInformationProvider extends RouteInformationProvider {
  late RouteInformation _routeInformation;

  CustomRouteInformationProvider() {
    // Set initial route information
    _routeInformation = RouteInformation(uri: Uri(path: '/'));
  }


  // Method to update the route information
  void updateRouteInformation(RouteInformation routeInformation) {
    _routeInformation = routeInformation;
  }
  
  @override
  void addListener(VoidCallback listener) {
  }
  
  @override
  void removeListener(VoidCallback listener) {

  }
  
  @override
  RouteInformation get value => _routeInformation;
}

class CustomRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  String _currentRoute = '/';

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_currentRoute == '/')
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomePage(onButtonPressed: _handleButtonPressed),
          ),
        if (_currentRoute == '/second')
          MaterialPage(
            key: const ValueKey('SecondPage'),
            child: SecondPage(onButtonPressed: _handleButtonPressed),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _currentRoute = '/';
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    _currentRoute = configuration;
    return SynchronousFuture<void>(null);
  }

  void _handleButtonPressed(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}

class CustomRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture<String>(routeInformation.uri.toString());
  }

  @override
  RouteInformation restoreRouteInformation(String path) {
    return RouteInformation(uri: Uri(path: path));
  }
}

class HomePage extends StatelessWidget {
  final void Function(String) onButtonPressed;

  const HomePage({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => onButtonPressed("/second"),
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final void Function(String) onButtonPressed;

  const SecondPage({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => onButtonPressed("/"),
          child: const Text('Go back to Home Page'),
        ),
      ),
    );
  }
}
