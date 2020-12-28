import 'package:flutter/material.dart';

import 'login_signup_fields.dart';

Form loginSignupForm({
  GlobalKey<FormState> formKey,
  TextEditingController emailController,
  TextEditingController passwordController,
  bool loading,
  String buttonText,
  Function buttonOnPressed,
}) {
  return Form(
    key: formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loginSignupInput(
            hint: "Email",
            icon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            isPassword: false,
            validator: (text) =>
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text)
                    ? null
                    : "Invalid Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress),
        loginSignupInput(
          hint: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          isPassword: true,
          validator: (String text) =>
              text.length < 6 ? "Password should be atleast 6 digits" : null,
          controller: passwordController,
        ),
        SizedBox(
          height: 35,
        ),
        loading
            ? CircularProgressIndicator(
                backgroundColor: Colors.red,
              )
            : RaisedButton(
                onPressed: buttonOnPressed,
                child: Text(buttonText),
              ),
      ],
    ),
  );
}
