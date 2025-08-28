import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class OTPVerificationComponent extends StatefulWidget {
  final String email;
  final Function() onVerified;
  final Function() onBack;

  const OTPVerificationComponent({
    super.key,
    required this.email,
    required this.onVerified,
    required this.onBack,
  });

  @override
  State<OTPVerificationComponent> createState() =>
      _OTPVerificationComponentState();
}

class _OTPVerificationComponentState extends State<OTPVerificationComponent> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  Timer? _timer;
  int _remainingTime = 75;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onOTPChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    bool allFilled = _otpControllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    if (allFilled) {
      // Auto verify when all fields are filled
      widget.onVerified();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Back Button

        // OTP Container with specified dimensions
        Container(
          width: 366,
          height: 267.07,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: const Color(0x1A000000), // #0000001A
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'lib/assets/back.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Verify your email',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  height: 1.2, // Line height as a multiplier of font size
                  letterSpacing: -0.02, // -2% letter spacing
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'OTP sent to ${widget.email}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 1.4, // Line height as a multiplier of font size
                  letterSpacing: 0.14, // 1% letter spacing
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 50,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0x33000000), // #00000033
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 22.09,
                        height: 1.2, // Reduced line height to prevent overflow
                        letterSpacing: -0.02, // -2% letter spacing
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                      ),
                      onChanged: (value) => _onOTPChanged(value, index),
                      onTap: () {
                        if (_otpControllers[index].text.isEmpty && index > 0) {
                          // Find the last empty field before this one
                          for (int i = 0; i < index; i++) {
                            if (_otpControllers[i].text.isEmpty) {
                              _focusNodes[i].requestFocus();
                              break;
                            }
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Resend OTP
              Center(
                child: Text(
                  'Resend OTP in ${_remainingTime}s',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Verify Button (outside the container)
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
