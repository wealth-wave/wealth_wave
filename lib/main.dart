import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/app_router.dart';

void main() {
  runApp(Provider<AppDatabase>(
      create: (context) => AppDatabase.instance,
      child: const WealthWaveApp(),
      dispose: (context, db) => db.close()));
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
        colorScheme: const ColorScheme.light(
          primary: Colors.teal, // A deep green, conveys stability and growth
          secondary: Colors.white, // A lighter teal, for a refreshing, modern feel
          surface: Colors.white, // A very light teal for backgrounds, provides contrast
          background: Colors.white, // A soft blue, calming and trustworthy
          error: Colors.red, // Standard error color for visibility
          onPrimary: Colors.white, // White text/icons on primary color for readability
          onSecondary: Colors.black, // Black text/icons on secondary for contrast and readability
          onSurface: Colors.black, // Black text/icons on surface color for readability
          onBackground: Colors.black, // Black text/icons on background for readability
          onError: Colors.white, // White text/icons on error color for readability
          brightness: Brightness.light, // Overall brightness, light theme
        ),
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
