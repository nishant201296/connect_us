import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/screens/login_screen.dart';
import 'package:connect_us/screens/signup_screen.dart';
import 'package:connect_us/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ConnectUs());
}

class ConnectUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect us',
      routes: {
        RoutesHelper.SPLASH: (context) => SafeArea(child: SplashScreen()),
        RoutesHelper.LOGIN: (context) => SafeArea(child: LoginScreen()),
        RoutesHelper.SIGN_UP: (context) => SafeArea(child: SignupScreen()),
      },
      initialRoute: RoutesHelper.SPLASH,
    );
  }
}
