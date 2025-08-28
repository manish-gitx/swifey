import 'package:flutter/material.dart';

class EmailInputComponent extends StatefulWidget {
  final Function(String) onNext;

  const EmailInputComponent({super.key, required this.onNext});

  @override
  State<EmailInputComponent> createState() => _EmailInputComponentState();
}

class _EmailInputComponentState extends State<EmailInputComponent> {
  final TextEditingController _emailController = TextEditingController();
  bool _isAgreed = false;
  bool _isValidEmail = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final email = _emailController.text;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    setState(() {
      _isValidEmail = emailRegex.hasMatch(email) && email.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366,
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Let's start with your email 👋",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              height: 1.2, // Line height as a multiplier of font size
              letterSpacing: -0.02, // -2% letter spacing
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),

          // Email Input Field
          Container(
            width: 318,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color(0xFFE0E0E0), // More visible gray border
                width: 1.4,
              ),
            ),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'peterjohn@gmail.com',
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Privacy Policy Checkbox
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF4B164C),
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Makes it round
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Next Button
          Container(
            width: 318,
            height: 55,
            child: ElevatedButton(
              onPressed: _isAgreed && _isValidEmail
                  ? () => widget.onNext(_emailController.text)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B164C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                elevation: 0,
                disabledBackgroundColor: const Color(
                  0xFF4B164C,
                ).withOpacity(0.3),
              ),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 19.22,
                  height: 1.2, // 120% line height
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }
}
