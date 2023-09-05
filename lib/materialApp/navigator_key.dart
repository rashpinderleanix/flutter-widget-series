

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
///GlobalKey<NavigatorState> is a special type of key that can be used to access the state of a widget across the widget tree. 
/// In the context of the Material App widget, it is used as the navigatorKey property to access the NavigatorState of the app's root navigator. 
///  This allows you to perform navigation actions, such as pushing and popping routes, from anywhere in your app, without having to pass the BuildContext down the widget tree.
///Here's an example that demonstrates the usage of GlobalKey<NavigatorState> as navigatorKey in a Flutter app:
///
// Create a GlobalKey<NavigatorState> instance
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Key Demo',
      navigatorKey: navigatorKey, // Assign the navigatorKey to MaterialApp
      home: const HomePage(),
      routes: {
        '/second': (context) => const SecondPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to SecondPage using the navigatorKey
            navigatorKey.currentState?.pushNamed('/second');
          },
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to HomePage using the navigatorKey
            navigatorKey.currentState?.pop();
          },
          child: const Text('Go back to Home Page'),
        ),
      ),
    );
  }
}
