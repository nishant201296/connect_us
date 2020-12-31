import 'package:flutter/material.dart';

import 'background_gradient.dart';

Widget ScreenWrapper({Widget child}) {
  return SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [backGroundGradient(), child],
      ),
    ),
  );
}
