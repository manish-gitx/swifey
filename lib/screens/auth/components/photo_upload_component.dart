import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadComponent extends StatefulWidget {
  final Function() onNext;
  final Function() onBack;

  const PhotoUploadComponent({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<PhotoUploadComponent> createState() => _PhotoUploadComponentState();
}

class _PhotoUploadComponentState extends State<PhotoUploadComponent> {
  final ImagePicker _picker = ImagePicker();
  final List<File?> _selectedImages = List.filled(6, null);

  Future<void> _pickImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImages[index] = File(image.path);
        });
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages[index] = null;
    });
  }

  bool get _hasAtLeastOnePhoto {
    return _selectedImages.any((image) => image != null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Photo Upload Container
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
                  "Add your photos",
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
              const SizedBox(height: 32),

              // Photo Grid
              SizedBox(
                width: 96 * 3 + 32, // 96px width per item + 16px spacing * 2
                height: 142 * 2 + 16, // 142px height per item + 16px spacing
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio:
                              96.0 / 142.0, // Using exact dimensions
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildPhotoSlot(index);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Next Button
              Center(
                child: SizedBox(
                  width: 318,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _hasAtLeastOnePhoto ? widget.onNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasAtLeastOnePhoto
                          ? const Color(0xFF4B164C)
                          : const Color(0xFFB8B8B8), // Gray when no photos
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

  Widget _buildPhotoSlot(int index) {
    final hasImage = _selectedImages[index] != null;

    return GestureDetector(
      onTap: () => hasImage ? _showImageOptions(index) : _pickImage(index),
      child: Container(
        width: 84.66667175292969,
        height: 91,
        padding: hasImage
            ? EdgeInsets.zero
            : const EdgeInsets.all(8.0), // No padding when image is uploaded
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB), // Light gray background
          borderRadius: BorderRadius.circular(7.7),
        ),
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  // Image takes full card space
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.7),
                    child: Image.file(
                      _selectedImages[index]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Remove/Edit overlay
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF8B1A96,
                        ), // Match the purple color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  // Centered skeleton image (smaller size)
                  Center(
                    child: Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'lib/assets/profile_skeleton.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Plus icon positioned at bottom center
                  Positioned(
                    bottom: 5,
                    left: 5,
                    right: 5,
                    top: 5,
                    child: Center(
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B164C),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFF5B3F1),
                          size: 20,
                          weight: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showImageOptions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Replace Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove Photo'),
              onTap: () {
                Navigator.pop(context);
                _removeImage(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
