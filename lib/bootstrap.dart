import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:news_app/services/storage.dart';
import 'package:news_app/style/style.dart';

void bootstrap({List<ProviderObserver>? observers}) async {
  await openBoxes();
  runApp(App(observers: observers));
}

class App extends StatelessWidget {
  const App({super.key, this.observers});

  final List<ProviderObserver>? observers;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: observers,
      child: MaterialApp(
        title: 'News App',
        home: const SplashScreen(),
        theme: ThemeData(
          colorSchemeSeed: Palette.primary,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }
}
