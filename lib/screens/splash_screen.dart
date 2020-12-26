import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _translateAnimation;
  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // setting the controller for splash animations.
    _controller = AnimationController(duration: Duration(milliseconds: 1300), vsync: this);

    // decelerate translate animation
    _translateAnimation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    // fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
          Duration(
            milliseconds: 1500,
          ),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        _backGroundGradient(),
        FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, -(_translateAnimation.value * 200)),
              child: Image.asset("images/1.png"),
            ))
      ],
    ));
  }

  Widget _backGroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.lightBlue[400],
          Colors.blue[700],
        ], stops: [
          0.0,
          1.0,
        ], begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight, tileMode: TileMode.repeated),
      ),
    );
  }
}
