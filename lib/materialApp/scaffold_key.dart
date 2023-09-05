import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Create a GlobalKey<ScaffoldMessengerState> instance
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Messenger Key Demo',
      scaffoldMessengerKey:
          scaffoldMessengerKey, // Assign the scaffoldMessengerKey to MaterialApp
      home: const HomePage(),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Show a SnackBar using the scaffoldMessengerKey
                scaffoldMessengerKey.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text('Hello from Home Page!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Show SnackBar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text('Go to Second Page'),
            ),
          ],
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
            // Show a SnackBar using the scaffoldMessengerKey
            scaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text('Hello from Second Page!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: const Text('Show SnackBar'),
        ),
      ),
    );
  }
}
