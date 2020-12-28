import 'package:connect_us/components/background_gradient.dart';
import 'package:connect_us/components/login_sign_form.dart';
import 'package:connect_us/routes_helper.dart';
import 'package:connect_us/utils/constants.dart';
import 'package:connect_us/utils/database_handler.dart';
import 'package:connect_us/utils/firebase_helper.dart';
import 'package:connect_us/utils/global_functions.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            backGroundGradient(),
            loginSignupForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                loading: _loading,
                buttonText: "Sign up",
                buttonOnPressed: () async {
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _loading = true;
                    });
                    try {
                      await firebaseAuth.createUserWithEmailAndPassword(
                          email: _emailController.value.text,
                          password: _passwordController.value.text);
                      setState(() {
                        DataBaseHandler.setValue(
                            Constants.USER_TOKEN, firebaseAuth.currentUser.uid);
                        _loading = false;
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
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Already a member? Click here to login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
