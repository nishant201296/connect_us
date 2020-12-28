import 'package:flutter/material.dart';

Widget loginSignupInput(
    {String hint = "",
    Icon icon,
    bool isPassword = false,
    Function validator,
    TextEditingController controller,
    TextInputType keyboardType}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintMaxLines: 1,
        hintText: hint,
        icon: icon,
        focusedBorder: _border(Colors.yellow, 2.0),
        enabledBorder: _border(Colors.white, 0.0),
        errorBorder: _border(Colors.red[400], 0.0),
        focusedErrorBorder: _border(Colors.red[400], 0.0),
      ),
    ),
  );
}

OutlineInputBorder _border(Color color, double width) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: color, width: width == 0 ? 1 : width),
  );
}
