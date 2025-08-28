import 'package:flutter/material.dart';
import 'package:swifey_assignment/screens/auth/auth_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/swipe.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String swipe = '/swipe';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case swipe:
        return MaterialPageRoute(builder: (_) => const SwipeScreen());
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
