import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/signin");
  }

  static void goToLoading(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/loading");
  }
}
