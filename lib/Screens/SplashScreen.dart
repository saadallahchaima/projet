import 'dart:math';
import 'package:flutter/material.dart';

class Bg extends StatefulWidget {
  @override
  _BgState createState() => _BgState();
}

class _BgState extends State<Bg> with SingleTickerProviderStateMixin {
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
      duration: Duration(seconds: 4),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.75, 1.0, curve: Curves.easeInOut),
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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    ? SizedBox.shrink() // Make the shape disappear when completed
                    : Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.7, -0.71),
                    end: Alignment(0.7, 0.71),
                    colors: [
                      Color(0xFF9F56FC),
                      Color(0xFFFF26A7),
                      Color(0xFFFF9A7A),
                      Color(0xFFE2D66E),
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
          SizedBox(height: 30), // Add some spacing between the shape and the text
          AnimatedOpacity(
            opacity: _shapeAnimationCompleted ? _textOpacityAnimation.value : 0.0,
            duration: Duration(milliseconds: 500),
            child: Text(
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
    );
  }
}
