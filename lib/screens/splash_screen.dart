import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/components/screen_wrapper.dart';
import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/utils/constants.dart';
import 'package:connect_us/utils/database_handler.dart';
import 'package:connect_us/utils/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

    initUtils();
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
            String token = DataBaseHandler.getValue(Constants.USER_TOKEN);
            Navigator.popAndPushNamed(
              context,
              token == null ? RoutesHelper.LOGIN : RoutesHelper.RECENT_CHATS,
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: Offset(0, -(_translateAnimation.value * 200)),
            child: Image.asset("images/1.png"),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initUtils() async {
    await Firebase.initializeApp();
    DataBaseHandler.init();
    NotificationService.getInstance().initialize();
  }
}
