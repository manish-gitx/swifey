import 'package:flutter/material.dart';
import '../models/onboarding_item.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 472,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F0A30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Main title (comes first)
          Text(
            item.title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 24,
              height: 1.2, // 120% line height
              letterSpacing: -0.48, // -2% of 24px
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Main illustration (comes second)
          Container(
            width: 242.40,
            height: 200,
            child: Image.asset(item.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          // Subtitle (comes third, if not empty)
          if (item.subtitle.isNotEmpty) ...[
            Text(
              item.subtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400, // Light weight
                fontSize: 17,
                height: 1.4, // 140% line height
                letterSpacing: 0, // 0% letter spacing
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
          // Description (comes last)
          Expanded(
            child: Center(
              child: Text(
                item.description,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.4, // 140% line height
                  letterSpacing: 0.26, // 2% of 13px
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
