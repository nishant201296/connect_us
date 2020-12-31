import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/screens/login_screen.dart';
import 'package:connect_us/screens/new_chat_screen.dart';
import 'package:connect_us/screens/recent_chats_screen.dart';
import 'package:connect_us/screens/signup_screen.dart';
import 'package:connect_us/screens/single_chat_screen.dart';
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
        RoutesHelper.SPLASH: (context) => SplashScreen(),
        RoutesHelper.LOGIN: (context) => LoginScreen(),
        RoutesHelper.SIGN_UP: (context) => SignupScreen(),
        RoutesHelper.RECENT_CHATS: (context) => RecentChatsScreen(),
        RoutesHelper.NEW_CHAT: (context) => NewChat(),
        RoutesHelper.SINGLE_CHAT: (context) => SingleChat(null),
      },
      initialRoute: RoutesHelper.SPLASH,
    );
  }
}
