import 'package:flutter/material.dart';
import 'package:radio_stations/core/design_system/theme/app_theme.dart';
import 'package:radio_stations/core/di/injection.dart';
import 'package:radio_stations/features/radio/presentation/pages/radio_page.dart';

/// The main entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await init();

  runApp(const MyApp());
}

/// The root widget of the application
///
/// This widget configures the app's theme and displays the main radio page.
class MyApp extends StatelessWidget {
  /// Creates a new instance of [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Stations',
      theme: AppTheme.darkTheme,
      home: RadioPage(
        cubit: getIt(),
      ),
    );
  }
}
