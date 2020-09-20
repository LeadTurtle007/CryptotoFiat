import 'package:cryptoapp/chat.dart';
import 'package:cryptoapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authenticate/Splash.dart';
import 'database/auth.dart';
import 'models/user.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';

var routes = <String, WidgetBuilder>{
  // "/home": (BuildContext context) => HomeScreen(),
  "/signin": (BuildContext context) => Wrapper(),
  // "/loading": (BuildContext context) => Home(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black54));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Crypto App',
          debugShowCheckedModeBanner: false,
          home: Splash(),
          routes: routes),
    );
  }
}
