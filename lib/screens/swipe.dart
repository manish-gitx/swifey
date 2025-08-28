import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import '../widgets/swipe_content.dart';
import '../widgets/bottom_navigation_widget.dart';

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
      name: 'Alex',
      age: 28,
      bio: 'Beach lover and fitness enthusiast 🏖️',
      location: 'Miami',
      gender: 'Male',
      photos: [
        'lib/assets/man.png', // This will be your beach photo
        'lib/assets/pic2.png',
        'lib/assets/pic3.png',
      ],
      distance: 2.3,
    ),
    User(
      id: '3',
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
      id: '4',
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
      id: '5',
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
      body: Stack(
        children: [
          // Animated main content
          _buildAnimatedContent(),

          // Fixed bottom navigation
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: const BottomNavigationWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return AnimatedBuilder(
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
      child: SwipeContent(
        users: _users,
        currentIndex: _currentIndex,
        animationController: _animationController,
        scaleAnimation: _scaleAnimation,
        dragDistance: _dragDistance,
        isAnimating: _isAnimating,
        onSwipeLeft: _onSwipeLeft,
        onSwipeRight: _onSwipeRight,
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
      ),
    );
  }
}
