import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'icon': Icons.explore, 'label': 'Discover', 'isActive': true},
      {'icon': Icons.star_outline, 'label': 'Pledges', 'isActive': false},
      {'icon': Icons.send, 'label': 'Airdrop', 'isActive': false},
      {'icon': Icons.chat_bubble_outline, 'label': 'Chats', 'isActive': false},
      {'icon': Icons.person_outline, 'label': 'Me', 'isActive': false},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0x26000000), // #00000026 in Flutter Color format
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          final isActive = tab['isActive'] as bool;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                tab['icon'] as IconData,
                color: isActive ? const Color(0xFF8B1E7B) : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                tab['label'] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? const Color(0xFF8B1E7B) : Colors.grey,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
