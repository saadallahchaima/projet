import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'WelcomScreen.dart';
import 'ajouter_info.dart';
import 'login_screen.dart';
class Bg extends StatefulWidget {
  static const routeName = '/splash-screen';

  @override
  _BgState createState() => _BgState();
}

class _BgState extends State<Bg> with SingleTickerProviderStateMixin {
  String? finalEmail;

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textOpacityAnimation;
  bool _shapeAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_shapeAnimationCompleted) {
        setState(() {
          _shapeAnimationCompleted = true;
        });
        _controller.reset();
        _controller.forward();
      } else if (status == AnimationStatus.dismissed && _shapeAnimationCompleted) {
        setState(() {
          _shapeAnimationCompleted = false;
        });
        _controller.forward();
      }
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_shapeAnimationCompleted) {
        setState(() {
          _shapeAnimationCompleted = true;
        });
        _controller.reset();
        _controller.forward();

        // Naviguer vers la page suivante lorsque l'animation est terminée
        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
      } else if (status == AnimationStatus.dismissed && _shapeAnimationCompleted) {
        setState(() {
          _shapeAnimationCompleted = false;
        });
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Set the background color to white
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: child,
              );
            },
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return _shapeAnimationCompleted
                    ? const SizedBox.shrink() // Make the shape disappear when completed
                    : Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.7, -0.71),
                    end: Alignment(0.7, 0.71),
                    colors: [
                      Color(0xFF56A1FC),
                      Color(0xFF26CCFF),
                      Color(0xFF0A58E5),
                      Color(0xFF010D28),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.50,
                      color: Colors.white.withOpacity(0.15000000596046448),
                    ),
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30), // Add some spacing between the shape and the text
          AnimatedOpacity(
            opacity: _shapeAnimationCompleted ? _textOpacityAnimation.value : 0.0,
            duration: const Duration(milliseconds: 500),
            child: const Text(
              'Drivo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.92,
                fontStyle: FontStyle.italic,
                fontFamily: 'Satoshi Variable',
                fontWeight: FontWeight.w900,
                letterSpacing: -5.20,
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
