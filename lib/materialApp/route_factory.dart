import 'package:flutter/material.dart';


class MyRouteFactoryApp extends StatelessWidget {
  const MyRouteFactoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Generate Route Demo',
      home: const HomePage(),
      onGenerateRoute:
          _onGenerateRoute, // Assign the _onGenerateRoute function to MaterialApp
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/second':
        final String message = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => SecondPage(message: message),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
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
            // Navigate to SecondPage using the onGenerateRoute
            Navigator.pushNamed(
              context,
              '/second',
              arguments: 'Hello from Home Page!',
            );
          },
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String message;

  const SecondPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
