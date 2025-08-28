import 'package:flutter/material.dart';
import 'components/email_input_component.dart';
import 'components/otp_verification_component.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentStep = 0; // 0: Email Input, 1: OTP Verification
  String _email = '';

  void _handleEmailNext(String email) {
    setState(() {
      _email = email;
      _currentStep = 1;
    });
  }

  void _handleOTPVerified() {
    // Navigate to next screen or handle successful verification
    print('OTP Verified successfully!');
    // You can navigate to home screen or next onboarding step here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP Verified Successfully!')));
  }

  void _handleBackToEmail() {
    setState(() {
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5B3F1), // Background color
          image: DecorationImage(
            image: AssetImage('lib/assets/onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo at top start
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'lib/assets/swifey2.png',
                      width: 90.94198608398438,
                      height: 27.237140655517578,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Main text logo - positioned in upper area
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Image.asset(
                            'lib/assets/text.png',
                            width: 196,
                            height: 99,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    // Dynamic Widget at bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: _currentStep == 0
                          ? EmailInputComponent(onNext: _handleEmailNext)
                          : OTPVerificationComponent(
                              email: _email,
                              onVerified: _handleOTPVerified,
                              onBack: _handleBackToEmail,
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
}
