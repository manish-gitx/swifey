import 'package:flutter/material.dart';
import 'components/email_input_component.dart';
import 'components/otp_verification_component.dart';
import 'components/profile_setup_component.dart';
import 'components/bio.dart';
import 'components/pickFlavour.dart' as pick_flavour;
import 'components/permissions.dart';
import 'components/photo_upload_component.dart';
import '../../navigation/app_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentStep =
      0; // 0: Email Input, 1: OTP Verification, 2: Profile Setup, 3: Bio, 4: Pick Flavour, 5: Permissions, 6: Photo Upload
  String _email = '';

  void _handleEmailNext(String email) {
    setState(() {
      _email = email;
      _currentStep = 1;
    });
  }

  void _handleOTPVerified() {
    // Move to profile setup step
    setState(() {
      _currentStep = 2;
    });
  }

  void _handleBackToEmail() {
    setState(() {
      _currentStep = 0;
    });
  }

  void _handleBackToOTP() {
    setState(() {
      _currentStep = 1;
    });
  }

  void _handleProfileSetupComplete() {
    // Move to bio step
    setState(() {
      _currentStep = 3;
    });
  }

  void _handleBackToProfile() {
    setState(() {
      _currentStep = 2;
    });
  }

  void _handleBioComplete(String bio) {
    // Move to pick flavour step
    setState(() {
      _currentStep = 4;
    });
  }

  void _handleBackToBio() {
    setState(() {
      _currentStep = 3;
    });
  }

  void _handlePickFlavourComplete(pick_flavour.Gender selectedGender) {
    // Move to permissions step
    setState(() {
      _currentStep = 5;
    });
  }

  void _handleBackToPickFlavour() {
    setState(() {
      _currentStep = 4;
    });
  }

  void _handlePermissionsComplete() {
    // Move to photo upload step
    setState(() {
      _currentStep = 6;
    });
  }

  void _handleBackToPermissions() {
    setState(() {
      _currentStep = 5;
    });
  }

  void _handlePhotoUploadComplete() {
    // Navigate to swipe screen
    Navigator.pushNamed(context, AppRouter.swipe);
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
                          : _currentStep == 1
                          ? OTPVerificationComponent(
                              email: _email,
                              onVerified: _handleOTPVerified,
                              onBack: _handleBackToEmail,
                            )
                          : _currentStep == 2
                          ? ProfileSetupComponent(
                              onNext: _handleProfileSetupComplete,
                              onBack: _handleBackToOTP,
                            )
                          : _currentStep == 3
                          ? BioInputComponent(
                              onNext: _handleBioComplete,
                              onBack: _handleBackToProfile,
                            )
                          : _currentStep == 4
                          ? pick_flavour.PickFlavourComponent(
                              onNext: _handlePickFlavourComplete,
                              onBack: _handleBackToBio,
                            )
                          : _currentStep == 5
                          ? PermissionsComponent(
                              onNext: _handlePermissionsComplete,
                              onBack: _handleBackToPickFlavour,
                            )
                          : PhotoUploadComponent(
                              onNext: _handlePhotoUploadComplete,
                              onBack: _handleBackToPermissions,
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
