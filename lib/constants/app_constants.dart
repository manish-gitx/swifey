import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF8B1E7B);
  static const Color secondary = Color(0xFFF5B3F1);
  static const Color background = Color(0xFFE088DC);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [secondary, background],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F5F5)],
  );
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFFFB3),
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  static const double borderRadius = 12.0;
  static const double borderRadiusLarge = 16.0;

  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  static const double buttonHeight = 50.0;
  static const double textFieldHeight = 56.0;
}

class AppStrings {
  static const String appName = 'Swifey';
  static const String welcomeBack = 'Welcome Back!';
  static const String getStarted = 'Get Started';
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = 'Don\'t have an account?';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String createAccount = 'Create Account';
  static const String signUpToGetStarted = 'Sign up to get started';
  static const String home = 'Home';
  static const String search = 'Search';
  static const String favorites = 'Favorites';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String logout = 'Logout';
  static const String editProfile = 'Edit Profile';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String phoneNumber = 'Phone Number';
  static const String bio = 'Bio';
  static const String notifications = 'Notifications';
  static const String darkMode = 'Dark Mode';
  static const String language = 'Language';
  static const String about = 'About';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';
  static const String version = 'Version';
  static const String contactSupport = 'Contact Support';
  static const String rateApp = 'Rate App';
}

class AppAssets {
  static const String logo = 'lib/assets/swifey.png';
  static const String textLogo = 'lib/assets/text.png';
  static const String onboardingBackground = 'lib/assets/onboarding.png';
}
