// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      localizationsDelegates: const [
        // Add the localization delegates for Material, Cupertino, and your custom delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MyLocalizationsDelegate(), // Add your custom localization delegate
      ],
      supportedLocales: const [
         Locale('en', 'US'), // English, United States
         Locale('es', 'ES'), // Spanish, Spain
        // Other locales can be added here
      ],
      localeListResolutionCallback:
          (List<Locale>? locales, Iterable<Locale> supportedLocales) {
        // Your custom logic to choose the best locale
        for (final locale in locales!) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
        }
        // If no match is found, return the first supported locale
        return supportedLocales.first;
      },
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        // Your custom logic to choose the best locale
        if (locale == null) {
          return supportedLocales.first;
        }

        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        // If no exact match is found, return the first supported locale with the same language code
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        // If no match is found, return the first supported locale
        return supportedLocales.first;
      },
    );
  }
}
class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  // Define a method to get localized values for a specific key
  String get hello {
    return _localizedValues[locale.languageCode]!['hello']!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello': 'Hello',
    },
    'es': {
      'hello': 'Hola',
    },
  };
}
class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
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
