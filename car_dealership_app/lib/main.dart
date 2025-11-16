import 'package:car_dealership_app/core/services/notification_scheduler.dart';
import 'package:car_dealership_app/core/services/notification_service.dart';
import 'package:car_dealership_app/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await NotificationService().init();
  // Here we would initialize the Isar database etc.

  // Schedule notifications
  await NotificationScheduler().scheduleDailyChecks();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدیریت نمایشگاه اتومبیل',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system, // Automatically switch based on system settings
      debugShowCheckedModeBanner: false,
      home: const MainScreen(), // Start with the main navigation screen
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.vazirmatnTextTheme(baseTheme.textTheme),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E5BFF), // Main color: Blue
        brightness: brightness,
        secondary: const Color(0xFF00C3A0), // Secondary color: Turquoise
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
