import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/components/login_sign_form.dart';
import 'package:connect_us/components/screen_wrapper.dart';
import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/utils/constants.dart';
import 'package:connect_us/utils/database_handler.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:connect_us/utils/global_functions.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      children: [
        Column(
          children: [
            Expanded(
              child: loginSignupForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                loading: _loading,
                buttonText: "Login",
                buttonOnPressed: () async {
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _loading = true;
                    });
                    try {
                      await firebaseAuth.signInWithEmailAndPassword(
                          email: _emailController.value.text,
                          password: _passwordController.value.text);
                      setState(() {
                        _loading = false;
                        DataBaseHandler.setValue(
                            Constants.USER_TOKEN, firebaseAuth.currentUser.uid);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(RoutesHelper.RECENT_CHATS, (route) => false);
                      });
                    } catch (ex) {
                      setState(() {
                        _loading = false;
                        Flushbar(
                          isDismissible: true,
                          message: getFirebaseErrorString(ex.code),
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          reverseAnimationCurve: Curves.decelerate,
                          forwardAnimationCurve: Curves.elasticOut,
                        ).show(context);
                      });
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutesHelper.SIGN_UP);
                },
                child: Text(
                  "New here? Click here to sign up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
