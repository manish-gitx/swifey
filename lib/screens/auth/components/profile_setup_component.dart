import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum Gender { man, woman, nonBinary }

class ProfileSetupComponent extends StatefulWidget {
  final Function() onNext;
  final Function() onBack;

  const ProfileSetupComponent({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<ProfileSetupComponent> createState() => _ProfileSetupComponentState();
}

class _ProfileSetupComponentState extends State<ProfileSetupComponent> {
  Gender? _selectedGender;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  DateTime? _selectedDate;
  int _selectedHeight = 170; // Default height in cm
  int _selectedWeight = 70; // Default weight in kg
  bool _isMetric = true; // true for kg, false for lb

  bool get _isFormValid {
    return _selectedGender != null &&
        _nameController.text.isNotEmpty &&
        _birthdayController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty;
  }

  Future<void> _selectDate(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,

        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime:
                _selectedDate ??
                DateTime.now().subtract(const Duration(days: 6570)),
            mode: CupertinoDatePickerMode.date,
            maximumDate: DateTime.now(),
            minimumDate: DateTime(1900),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
                _birthdayController.text =
                    "${newDate.day.toString().padLeft(2, '0')} / ${newDate.month.toString().padLeft(2, '0')} / ${newDate.year}";
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectHeight(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: _selectedHeight - 120,
            ),
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                _selectedHeight = selectedItem + 120;
                _heightController.text = '$_selectedHeight cm';
              });
            },
            children: List<Widget>.generate(100, (int index) {
              final height = index + 120;
              return Center(child: Text('$height cm'));
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _selectWeight(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // Unit toggle
              Container(
                padding: const EdgeInsets.all(16),
                child: CupertinoSegmentedControl<bool>(
                  children: const {true: Text('kg'), false: Text('lb')},
                  onValueChanged: (bool value) {
                    setState(() {
                      _isMetric = value;
                      if (_isMetric) {
                        _selectedWeight = (_selectedWeight * 0.453592).round();
                      } else {
                        _selectedWeight = (_selectedWeight * 2.20462).round();
                      }
                      _weightController.text =
                          '$_selectedWeight ${_isMetric ? 'kg' : 'lb'}';
                    });
                  },
                  groupValue: _isMetric,
                ),
              ),
              // Weight picker
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedWeight - (_isMetric ? 30 : 66),
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedWeight = selectedItem + (_isMetric ? 30 : 66);
                      _weightController.text =
                          '$_selectedWeight ${_isMetric ? 'kg' : 'lb'}';
                    });
                  },
                  children: List<Widget>.generate(
                    _isMetric ? 150 : 300, // 30-180 kg or 66-366 lb
                    (int index) {
                      final weight = index + (_isMetric ? 30 : 66);
                      return Center(
                        child: Text('$weight ${_isMetric ? 'kg' : 'lb'}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set initial values
    _heightController.text = '$_selectedHeight cm';
    _weightController.text = '$_selectedWeight kg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title with emoji
          const Center(
            child: Text(
              "Let's get to know you 😊",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                height: 1.2,
                letterSpacing: -0.02,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Gender Selection
          const Text(
            'Gender',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildGenderOption(Gender.man, 'Man', "lib/assets/man.png"),
              const SizedBox(width: 12),
              _buildGenderOption(Gender.woman, 'Woman', "lib/assets/women.png"),
              const SizedBox(width: 12),
              _buildGenderOption(
                Gender.nonBinary,
                'Non-binary',
                "lib/assets/non-binary.png",
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Name Field
          Center(
            child: _buildNameField(
              controller: _nameController,
              hintText: 'John Doe',
            ),
          ),
          const SizedBox(height: 20),

          // Birthday Field
          Center(
            child: _buildBirthdayField(
              controller: _birthdayController,
              hintText: '',
              onTap: () => _selectDate(context),
            ),
          ),
          const SizedBox(height: 20),

          // Height Field
          Center(
            child: _buildHeightField(
              controller: _heightController,
              onTap: () => _selectHeight(context),
            ),
          ),
          const SizedBox(height: 20),

          // Weight Field
          Center(
            child: _buildWeightField(
              controller: _weightController,
              onTap: () => _selectWeight(context),
            ),
          ),
          const SizedBox(height: 20),

          // Referral Code Field
          Center(
            child: _buildReferralField(
              controller: _referralCodeController,
              hintText: '------',
            ),
          ),
          const SizedBox(height: 32),

          // Next Button
          Center(
            child: SizedBox(
              width: 318,
              height: 55,
              child: ElevatedButton(
                onPressed: _isFormValid ? widget.onNext : null,
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
    );
  }

  Widget _buildGenderOption(Gender gender, String label, String imagePath) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
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
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
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
      ),
    );
  }

  Widget _buildHeightField({
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 318,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: const Color(0x0D010101), // #0101010D
            width: 1.4,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Height',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              controller.text.isEmpty ? 'cm' : controller.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: controller.text.isEmpty
                    ? Colors.grey.shade500
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightField({
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 318,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: const Color(0x0D010101), // #0101010D
            width: 1.4,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Weight',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              controller.text.isEmpty ? 'kg/lb' : controller.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: controller.text.isEmpty
                    ? Colors.grey.shade500
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      width: 318,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0x0D010101), // #0101010D
          width: 1.4,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Referral Code (Optional)',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (_) {
                setState(() {}); // Trigger rebuild to update button state
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      width: 318,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0x0D010101), // #0101010D
          width: 1.4,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Name',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (_) {
                setState(() {}); // Trigger rebuild to update button state
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayField({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 318,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: const Color(0x0D010101), // #0101010D
            width: 1.4,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Birthday',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              controller.text.isEmpty ? 'DD / MM / YYYY' : controller.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: controller.text.isEmpty
                    ? Colors.grey.shade500
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }
}
