import 'package:flutter/material.dart';

import 'background_gradient.dart';

Widget ScreenWrapper(
    {List<Widget> children, AppBar appBar, FloatingActionButton floatingActionButton}) {
  return SafeArea(
    child: Scaffold(
      appBar: appBar ?? null,
      floatingActionButton: floatingActionButton ?? null,
      body: Stack(
        alignment: Alignment.center,
        children: [backGroundGradient(), ...children],
      ),
    ),
  );
}
