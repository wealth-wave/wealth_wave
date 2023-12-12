import 'package:flutter/material.dart';
import 'package:wealth_wave/app_router.dart';

void main() {
  runApp(const WealthWaveApp());
}

class WealthWaveApp extends StatelessWidget {
  const WealthWaveApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            settings: RouteSettings(
                name: settings.name, arguments: settings.arguments),
            maintainState: true,
            builder: (context) => AppRouter.route(settings.name!));
      },
    );
  }
}
