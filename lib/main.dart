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
      home: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
