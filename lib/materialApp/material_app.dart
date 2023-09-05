import 'package:flutter/material.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Themed App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(
                title: const Text('My First Page'),
              ),
              body: const Center(
                child: Text('Hello, World!'),
              ),
            ),
        '/second': (context) => Scaffold(
              appBar: AppBar(
                title: const Text('My Second Page'),
              ),
              body: const Center(
                child: Text('Hello, World!'),
              ),
            ),
      },
    );
  }
}
