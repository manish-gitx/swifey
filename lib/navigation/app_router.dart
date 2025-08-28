import 'package:flutter/material.dart';
import 'package:swifey_assignment/screens/auth/auth_screen.dart';
import '../screens/onboarding_screen.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
