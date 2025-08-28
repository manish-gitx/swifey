import 'package:flutter/material.dart';
import 'navigation/app_router.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B1E7B),
          primary: const Color(0xFF8B1E7B),
          secondary: const Color(0xFFF5B3F1),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const OnboardingScreen(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.onboarding,
    );
  }
}
