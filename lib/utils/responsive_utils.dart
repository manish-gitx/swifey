import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isSmallScreen(BuildContext context) => screenWidth(context) < 360;

  static bool isMediumScreen(BuildContext context) =>
      screenWidth(context) >= 360 && screenWidth(context) < 400;

  static bool isLargeScreen(BuildContext context) =>
      screenWidth(context) >= 400;

  // Get responsive width based on screen size
  static double getResponsiveWidth(
    BuildContext context, {
    double smallScreen = 320,
    double mediumScreen = 360,
    double largeScreen = 400,
  }) {
    final width = screenWidth(context);
    if (width < 360) {
      return width * 0.9; // 90% of screen width for small screens
    } else if (width < 400) {
      return mediumScreen;
    } else {
      return width * 0.85; // 85% of screen width for large screens
    }
  }

  // Get responsive height based on screen size
  static double getResponsiveHeight(BuildContext context, double baseHeight) {
    final height = screenHeight(context);
    if (height < 700) {
      return baseHeight * 0.85; // Reduce height for smaller screens
    } else if (height > 900) {
      return baseHeight * 1.1; // Increase height for larger screens
    }
    return baseHeight;
  }

  // Get responsive font size
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    final width = screenWidth(context);
    if (width < 360) {
      return baseFontSize * 0.9;
    } else if (width > 400) {
      return baseFontSize * 1.05;
    }
    return baseFontSize;
  }

  // Get responsive padding
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    double horizontal = 24.0,
    double vertical = 24.0,
  }) {
    final width = screenWidth(context);
    final horizontalPadding = width < 360 ? horizontal * 0.8 : horizontal;
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: vertical,
    );
  }

  // Get responsive margin
  static EdgeInsets getResponsiveMargin(
    BuildContext context, {
    double horizontal = 20.0,
    double vertical = 20.0,
  }) {
    final width = screenWidth(context);
    final horizontalMargin = width < 360 ? horizontal * 0.8 : horizontal;
    return EdgeInsets.symmetric(
      horizontal: horizontalMargin,
      vertical: vertical,
    );
  }

  // Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // Check if device is in landscape mode
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  // Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context) {
    final height = screenHeight(context);
    if (height < 700) {
      return 48.0;
    } else if (height > 900) {
      return 60.0;
    }
    return 55.0;
  }

  // Get responsive card height for onboarding
  static double getResponsiveCardHeight(BuildContext context) {
    final height = screenHeight(context);
    if (height < 700) {
      return height * 0.55; // 55% of screen height for small screens
    } else if (height > 900) {
      return height * 0.5; // 50% for large screens
    }
    return 472.0; // Default height
  }
}
