import 'package:flutter/material.dart';
import '../utils/onboarding_constants.dart';
import '../widgets/onboarding_card.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _nextPage() {
    if (_currentIndex < OnboardingConstants.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4B164C), // Background color
          image: DecorationImage(
            image: AssetImage('lib/assets/onboarding0.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Swifey logo image (static)
              SizedBox(
                width: 90.94,
                height: 31.57,
                child: Image.asset(
                  'lib/assets/swifey.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 60),
              // Card content area (only this changes)
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 472,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: OnboardingConstants.items.length,
                      padEnds: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: OnboardingCard(
                            item: OnboardingConstants.items[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Bottom section with indicator and button (static)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Page indicator
                    PageIndicator(
                      currentIndex: _currentIndex,
                      totalPages: OnboardingConstants.items.length,
                    ),
                    const SizedBox(height: 32),
                    // Start Dating button
                    SizedBox(
                      width: 360,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          foregroundColor: const Color(0xFF6B1E7B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        ),
                        child: Text(
                          _currentIndex == OnboardingConstants.items.length - 1
                              ? 'Start Dating'
                              : 'Start Dating',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
