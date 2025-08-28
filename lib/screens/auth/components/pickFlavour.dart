import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Gender { man, woman, nonBinary }

class PickFlavourComponent extends StatefulWidget {
  final Function(Gender) onNext;
  final Function() onBack;

  const PickFlavourComponent({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<PickFlavourComponent> createState() => _PickFlavourComponentState();
}

class _PickFlavourComponentState extends State<PickFlavourComponent> {
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
  }

  bool get _isFormValid {
    return _selectedGender != null;
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
                  "Pick your flavour",
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
              const SizedBox(height: 14),

              // Gender Selection
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGenderOption(Gender.man, 'Man', "lib/assets/man.png"),
                    const SizedBox(width: 16),
                    _buildGenderOption(
                      Gender.woman,
                      'Woman',
                      "lib/assets/women.png",
                    ),
                    const SizedBox(width: 16),
                    _buildGenderOption(
                      Gender.nonBinary,
                      'Non-binary',
                      "lib/assets/non-binary.png",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 27),

              // Next Button
              Center(
                child: Container(
                  width: 318,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isFormValid
                        ? () => widget.onNext(_selectedGender!)
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

  Widget _buildGenderOption(Gender gender, String label, String imagePath) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        width: 95.33,
        height: 101,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECDCFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.contain),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: isSelected
                    ? const Color(0xFF8B5CF6)
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
