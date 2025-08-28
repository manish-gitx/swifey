import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _translationAnimation;
  late Animation<double> _scaleAnimation;

  int _currentIndex = 0;
  double _dragDistance = 0;
  bool _isAnimating = false;

  // Mock data based on the UI preview
  final List<User> _users = [
    User(
      id: '1',
      name: 'Anya',
      age: 27,
      bio: 'do you accept the mission?',
      location: 'Cambridge',
      gender: 'Female',
      photos: [
        'lib/assets/mockdata1.png',
        'lib/assets/pic2.png',
        'lib/assets/pic3.png',
      ],
      distance: 1.5,
    ),
    User(
      id: '2',
      name: 'Emma',
      age: 24,
      bio: 'Adventure seeker and coffee lover ☕',
      location: 'New York',
      gender: 'Female',
      photos: [
        'lib/assets/pic2.png',
        'lib/assets/mockdata1.png',
        'lib/assets/pic3.png',
      ],
      distance: 2.1,
    ),
    User(
      id: '3',
      name: 'Sophie',
      age: 26,
      bio: 'Artist and dreamer 🎨',
      location: 'Paris',
      gender: 'Female',
      photos: [
        'lib/assets/pic3.png',
        'lib/assets/mockdata1.png',
        'lib/assets/pic2.png',
      ],
      distance: 3.2,
    ),
    User(
      id: '4',
      name: 'Olivia',
      age: 25,
      bio: 'Yoga instructor & nature lover 🌿',
      location: 'Los Angeles',
      gender: 'Female',
      photos: [
        'lib/assets/mockdata1.png',
        'lib/assets/pic3.png',
        'lib/assets/pic2.png',
      ],
      distance: 4.8,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Initialize animations
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _translationAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onSwipeLeft() {
    if (_isAnimating) return;
    _animateSwipe(false);
  }

  void _onSwipeRight() {
    if (_isAnimating) return;
    _animateSwipe(true);
  }

  void _animateSwipe(bool isLike) {
    setState(() {
      _isAnimating = true;
      _dragDistance = isLike ? 300 : -300;
    });

    _animationController.forward().then((_) {
      _nextUser();
      _animationController.reset();
      setState(() {
        _isAnimating = false;
        _dragDistance = 0;
      });
    });
  }

  void _nextUser() {
    if (_currentIndex < _users.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Reset to first user or show end screen
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: (details) {
          if (!_isAnimating) {
            _scaleController.forward();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (!_isAnimating) {
            setState(() {
              _dragDistance += details.delta.dx;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          _scaleController.reverse();

          if (!_isAnimating) {
            if (_dragDistance.abs() > 100) {
              // Trigger swipe animation
              _animateSwipe(_dragDistance > 0);
            } else {
              // Snap back to center
              setState(() {
                _dragDistance = 0;
              });
            }
          }
        },
        child: Stack(
          children: [
            // Main content with whole-screen animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final rotation = _isAnimating
                    ? (_dragDistance > 0
                        ? _rotationAnimation.value
                        : -_rotationAnimation.value)
                    : _dragDistance * 0.0005;
                final translation = _isAnimating
                    ? (_dragDistance > 0
                        ? _translationAnimation.value
                        : -_translationAnimation.value)
                    : _dragDistance * 0.5;

                return Transform.translate(
                  offset: Offset(translation, 0),
                  child: Transform.rotate(
                    angle: rotation,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, inner) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                    ),
                  ),
                );
              },
              child: SafeArea(
                child: Column(
                  children: [
                    // Main card area
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: _buildCardStack(),
                      ),
                    ),

                    // Bottom section with gender/location info
                    _buildBottomInfoSection(_users[_currentIndex]),

                    // Action buttons
                    _buildActionButtons(),

                    // Space for fixed bottom navigation
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Fixed bottom navigation with gesture blocker
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (_) {}, // Block horizontal swipes on navigation
                onHorizontalDragUpdate: (_) {},
                onHorizontalDragEnd: (_) {},
                child: _buildBottomNavigation(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardStack() {
    return Stack(
      children: [
        // Background card (next user)
        if (_currentIndex + 1 < _users.length)
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 0.95 + (0.05 * _animationController.value),
                child: _buildUserCard(
                  _users[_currentIndex + 1],
                  isBackground: true,
                ),
              );
            },
          ),

  // Front card (current user) - no per-card transform; whole screen animates
  _buildUserCard(_users[_currentIndex]),
      ],
    );
  }

  Widget _buildUserCard(User user, {bool isBackground = false}) {
    return Opacity(
      opacity: isBackground ? 0.8 : 1.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  user.photos.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              // Distance badge (top right)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${user.distance} km',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Small profile picture with book background (bottom left)
              Positioned(
                bottom: 140,
                left: 16,
                child: SizedBox(
                  width: 49.19,
                  height: 62.83,
                  child: Stack(
                    children: [
                      // Book background
                      Container(
                        width: 49.19,
                        height: 62.83,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'lib/assets/book.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.brown[300],
                                child: const Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Precisely positioned profile picture
                      Positioned(
                        top: 15.96,
                        left: 11.19,
                        child: Container(
                          width: 27.35,
                          height: 29.86,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 0.76,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              user.photos.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[400],
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // User info overlay at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name and age
                      Text(
                        '${user.name}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Bio
                      Text(
                        user.bio,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location with icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  user.location,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfoSection(User user) {
    return Container(
      width: 359,
      height: 74,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Gender info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.gender,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Location info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.location,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Reject button
          GestureDetector(
            onTap: _onSwipeLeft,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.close, color: Colors.grey, size: 30),
            ),
          ),

          // Like button
          GestureDetector(
            onTap: _onSwipeRight,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF8B1E7B),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B1E7B).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
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
