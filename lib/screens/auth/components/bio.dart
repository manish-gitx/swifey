import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BioInputComponent extends StatefulWidget {
  final Function(String) onNext;
  final Function() onBack;

  const BioInputComponent({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<BioInputComponent> createState() => _BioInputComponentState();
}

class _BioInputComponentState extends State<BioInputComponent> {
  final TextEditingController _bioController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _bioController.addListener(_validateBio);
  }

  void _validateBio() {
    setState(() {
      _hasText = _bioController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Bio Container with back button
        Container(
          width: 366,
          height: 316,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
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
              const SizedBox(height: 7),

              // Title centered
              Center(
                child: const Text(
                  "Your bio",
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
              ),
              const SizedBox(height: 24),

              // Bio Text Area
              Container(
                width: 318,
                height: 101,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: TextField(
                  controller: _bioController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Looking for someone who gets my references.',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),

              // Next Button
              Center(
                child: Container(
                  width: 318,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _hasText
                        ? () => widget.onNext(_bioController.text)
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bioController.removeListener(_validateBio);
    _bioController.dispose();
    super.dispose();
  }
}
