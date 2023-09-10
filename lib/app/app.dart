import 'package:app/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.appLoader});

  final Future<void> appLoader;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appLoader,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: generateLightTheme(),
            darkTheme: generateDarkTheme(),
            home: const SplashPage(),
          );
        }
        return MaterialApp.router(
          theme: generateLightTheme(),
          darkTheme: generateDarkTheme(),
          routerConfig: routerConfig,
        );
      },
    );
  }
}
