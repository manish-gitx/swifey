import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PermissionsComponent extends StatefulWidget {
  final Function() onNext;
  final Function() onBack;

  const PermissionsComponent({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<PermissionsComponent> createState() => _PermissionsComponentState();
}

class _PermissionsComponentState extends State<PermissionsComponent> {
  bool _notificationsEnabled = false;
  bool _locationEnabled = false;
  bool _photosEnabled = false;
  bool _cameraEnabled = false;

  // Check if at least one permission is enabled to determine button state
  bool get _hasPermissions {
    return _notificationsEnabled ||
        _locationEnabled ||
        _photosEnabled ||
        _cameraEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Permissions Container
        Container(
          width: 366,
          height: 566,
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
              const SizedBox(height: 14),

              // Title
              const Center(
                child: Text(
                  "Let's Set Things Up",
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
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Center(
                child: Text(
                  'Give us permission to vibe 🌸',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    height: 1.4, // Line height as a multiplier of font size
                    letterSpacing: 0.14, // 1% letter spacing
                    color: Color(0xFF6B7280), // Gray-500
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Permission Items
              _buildPermissionItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Get notified for matches, messages, and more.',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              _buildPermissionItem(
                icon: Icons.location_on_outlined,
                title: 'Find matches nearby',
                subtitle: 'Connect with people nearby.',
                value: _locationEnabled,
                onChanged: (value) {
                  setState(() {
                    _locationEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              _buildPermissionItem(
                icon: Icons.photo_outlined,
                title: 'Photos',
                subtitle: 'For sharing your best moments',
                value: _photosEnabled,
                onChanged: (value) {
                  setState(() {
                    _photosEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              _buildPermissionItem(
                icon: Icons.camera_alt_outlined,
                title: 'Camera',
                subtitle: 'To verify your profile securely',
                value: _cameraEnabled,
                onChanged: (value) {
                  setState(() {
                    _cameraEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Privacy text
              const Center(
                child: Text(
                  'We guard your info like a first date secret.\nChange anything, anytime.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF10B981), // Green
                  ),
                ),
              ),
              const SizedBox(height: 17),

              // Next Button
              Center(
                child: SizedBox(
                  width: 318,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasPermissions
                          ? const Color(0xFF4B164C)
                          : const Color(0xFFB8B8B8), // Gray when no permissions
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                      elevation: 0,
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

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        // Icon container
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(
            icon,
            color: const Color(0xFFEC4899), // Pink icon only, no background
            size: 24,
          ),
        ),
        const SizedBox(width: 16),

        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.2, // 120% line height
                  letterSpacing: -0.02, // -2% letter spacing
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.4, // 140% line height
                  letterSpacing: 0, // 0% letter spacing
                  color: Color(0xFF6B7280), // Gray-500
                ),
              ),
            ],
          ),
        ),

        // Switch
        Transform.scale(
          scale: 1,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF10B981), // Green
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE5E7EB), // Gray-200
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
