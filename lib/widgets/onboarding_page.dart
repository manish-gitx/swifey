import 'package:flutter/material.dart';
import '../models/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Swifey logo image
            SizedBox(
              width: 90.94,
              height: 31.57,
              child: Image.asset('lib/assets/swifey.png', fit: BoxFit.contain),
            ),
            const SizedBox(height: 60),
            // Card container with content
            Expanded(
              child: Center(
                child: Container(
                  width: 360,
                  height: 472,
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F0A30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Main illustration
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(item.image, fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Content section
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // Main title
                            Text(
                              item.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            // Description
                            Text(
                              item.description,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
