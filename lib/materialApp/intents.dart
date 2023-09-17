import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const IntentApp());
}

class IntentApp extends StatelessWidget {
  const IntentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD):
            const SaveIntent(),
        // Add more keyboard shortcuts here
      },
      actions: {
        SaveIntent: CallbackAction(onInvoke: (Intent intent) => _saveData()),
        CustomButtonTapIntent: CallbackAction(
            onInvoke: (Intent intent) => _handleCustomButtonTap()),
        // Add more actions for other intents here
      },
    );
  }

  void _saveData() {
    print('Data saved');
  }
  void _handleCustomButtonTap() {
    print('Custom button tapped');
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Press "Alt + S" to trigger the save action.'),
            Actions(
              actions: {
                CustomButtonTapIntent: CallbackAction(
                    onInvoke: (Intent intent) => _handleCustomButtonTap()),
              },
              child: CustomButton(),
            ),
          ],
        ),
      ),
    );
  }
   void _handleCustomButtonTap() {
    print('Custom button tapped');
  }
}

class SaveIntent extends Intent {
  const SaveIntent();
}
class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final action = Actions.handler<CustomButtonTapIntent>(
            context, const CustomButtonTapIntent());
        action?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Custom Button',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomButtonTapIntent extends Intent {
  const CustomButtonTapIntent();
}
