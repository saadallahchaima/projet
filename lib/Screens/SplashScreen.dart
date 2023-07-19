import 'package:flutter/material.dart';
import 'dart:async';

import 'package:projet/Screens/WelcomScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
  ));
}

class SplashPage extends StatefulWidget {
  static const routeName = '/splash-screen';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Augmenter la durée de l'animation
    );

    _animation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _timer = Timer(Duration(seconds: 3), () {
      _animationController.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: Offset(150 * _animation.value, 0), // Ajuster la valeur de décalage
                  child: child,
                ),
              );
            },
            child: Image.asset(
              'assets/petrol.png',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
