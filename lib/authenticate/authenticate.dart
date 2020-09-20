import 'package:cryptoapp/authenticate/signin.dart';
import 'package:cryptoapp/authenticate/signup.dart';
import 'package:flutter/material.dart';

class Authanticate extends StatefulWidget {
  @override
  _AuthanticateState createState() => _AuthanticateState();
}

class _AuthanticateState extends State<Authanticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView: toggleView);
    } else {
      return SignupPage(toggleView: toggleView);
    }
  }
}
